//
//  KCTestBinderVC.swift
//  kylRxMemoryDemo
//
//  Created by yulu kong on 2019/8/24.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class KCTestBinderVC: UIViewController {

    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var textFiled: UITextField!
    @IBOutlet weak var label: UILabel!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signalDemo()
    }
    

    func observerDemo() {
        // 序列 绑定到 observer
        // bind -> binder
        // ControlProperty -> ControlPropertyType -> ObservableType,ObserverType
        // 上面的继承和遵循关系说明了什么
        // 可以作为绑定的序列发起者,也可以作为binder
        self.textFiled.rx.text
            .bind(to: self.label.rx.text)
            .disposed(by: disposeBag)
        
        print("******************************")
        
        // binder
        // 不会处理错误事件
        // 确保绑定都是在给定 Scheduler 上执行（默认 MainScheduler）
        // 一旦产生错误事件，在调试环境下将执行 fatalError，在发布环境下将打印错误信息。
        
        let observer : AnyObserver<Bool> = AnyObserver { (event) in
            print("observer当前线程:\(Thread.current)")
            switch event{
            case .next(let isHidden) :
                print("来了,请看label的状态")
                self.label.isHidden = isHidden
            case .error(let error) :
                print("\(error)")
            case .completed :
                print("完成了")
            }
        }
        
        let binder = Binder<Bool>(self.label) { (lab, isHidden) in
            print("Binder当前线程:\(Thread.current)")
            lab.isHidden = isHidden
        }
        
        let observable = Observable<Bool>.create { (ob) -> Disposable in
            ob.onNext(true)
            ob.onError(NSError.init(domain: "com.lgcoooci.cn", code: 10086, userInfo: nil))
            ob.onCompleted()
            return Disposables.create()
            }.observeOn(ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global()))
        
        observable.bind(to: observer).disposed(by: self.disposeBag)
        
        
    }
    
    /// single
    func singleDemo() {
        /**
         * Single 是 Observable 的另外一个版本。不像 Observable 可以发出多个元素，它要么只能发出一个元素，要么产生一个 error 事件。
         * 发出一个元素，或一个 error 事件
         * 不会共享附加作用
         */
        let singleOB = Single<Any>.create { (single) -> Disposable in
            print("singleOB 是否共享")
            single(.success("Cooci"))
            single(.error(NSError.init(domain: "com.lgcoooci.cn", code: 10086, userInfo: nil)))
            return Disposables.create()
        }
        
        singleOB.subscribe { (reslut) in
            print("订阅:\(reslut)")
            }.disposed(by: disposeBag)
        
        singleOB.subscribe { (reslut) in
            print("订阅:\(reslut)")
            }.disposed(by: disposeBag)
    }
    
    /// Completable
    func completableDemo() {
        /**
         * Completable 是 Observable 的另外一个版本。不像 Observable 可以发出多个元素，它要么只能产生一个 completed 事件，要么产生一个 error 事件
         * 发出零个元素
         * 发出一个 completed 元素，或一个 error 事件
         * 不会共享附加作用
         * Completable 适用于那种你只关心任务是否完成，而不需要在意任务返回值的情况。它和 Observable<Void> 有点相似。
         */
        let completableOB = Completable.create { (completable) -> Disposable in
            print("completableOB 是否共享")
            completable(.completed)
            completable(.error(NSError.init(domain: "com.lgcoooci.cn", code: 10086, userInfo: nil)))
            return Disposables.create()
        }
        
        completableOB.subscribe { (reslut) in
            print("订阅:\(reslut)")
            }.disposed(by: disposeBag)
        
        completableOB.subscribe { (reslut) in
            print("订阅:\(reslut)")
            }.disposed(by: disposeBag)
    }
    
    /// Maybe
    func maybeDemo() {
        /**
         * Maybe 是 Observable 的另外一个版本。它介于 Single 和 Completable 之间，它要么只能发出一个元素，要么产生一个 completed 事件，要么产生一个 error 事件。
         
         * 发出一个元素或者一个 completed 事件或者一个 error 事件
         * 不会共享附加作用
         * 如果你遇到那种可能需要发出一个元素，又可能不需要发出时，就可以使用 Maybe。
         */
        let maybeOB = Maybe<Any>.create { (maybe) -> Disposable in
            print("maybe 是否共享")
            maybe(.success("Cooci"))
            maybe(.completed)
            maybe(.error(NSError.init(domain: "com.lgcoooci.cn", code: 10086, userInfo: nil)))
            return Disposables.create()
        }
        
        maybeOB.subscribe { (reslut) in
            print("订阅:\(reslut)")
            }.disposed(by: disposeBag)
        
        maybeOB.subscribe { (reslut) in
            print("订阅:\(reslut)")
            }.disposed(by: disposeBag)
    }
    
    /// ControlEvent
    func controlEventDemo() {
        /**
         * ControlEvent: 专门用于描述 UI 控件所产生的事件，它具有以下特征
         
         * 不会产生 error 事件
         * 一定在 MainScheduler 订阅（主线程订阅）
         * 一定在 MainScheduler 监听（主线程监听）
         * 会共享附加作用
         */
        
        let controlEventOB = self.btn.rx.controlEvent(.touchUpInside)
        
        controlEventOB.subscribe { (reslut) in
            print("订阅:\(reslut) \n \(Thread.current)")
            }.disposed(by: disposeBag)
        
        controlEventOB.subscribe { (reslut) in
            print("订阅:\(reslut) \n \(Thread.current)")
            }.disposed(by: self.disposeBag)
    }
    
    /// Driver
    func driverDemo() {
        /**
         * Driver 是一个精心准备的特征序列。它主要是为了简化 UI 层的代码。不过如果你遇到的序列具有以下特征，你也可以使用它：
         
         * 不会产生 error 事件
         * 一定在 MainScheduler 监听（主线程监听）
         * 会共享附加作用
         */
        let result = self.textFiled.rx.text.orEmpty
            .asDriver() // 普通序列转化为
            .throttle(0.5)
            .flatMap {
                self.dealwithData(inputText: $0)
                    .asDriver(onErrorJustReturn: "检测到了错误")
        }
        
        // 绑定到label上面
        result.map { "长度:\(($0 as! String).count)" }
            .drive(self.label.rx.text)
            .disposed(by: disposeBag)
        // 绑定到button上面
        result.map { ($0 as! String) }
            .drive(self.btn.rx.title())
            .disposed(by: disposeBag)
    }
    
    /// Signal
    func signalDemo() {
        /**
         * Signal 和 Driver 相似，唯一的区别是，Driver 会对新观察者回放（重新发送）上一个元素，而 Signal 不会对新观察者回放上一个元素。
         * 这个demo运行 label 是有值的,但是对于我们的新的观察者btn是没有值
         * 不会产生 error 事件
         * 一定在 MainScheduler 监听（主线程监听）
         * 会共享附加作用
         */
        let result = self.textFiled.rx.text.orEmpty
            .asSignal(onErrorJustReturn: "没有值") // 普通序列转化为signle
            .throttle(5)
            .flatMap {
                self.dealwithData(inputText: $0)
                    .asSignal(onErrorJustReturn: "检测到了错误")
        }
        
        // 绑定到label上面
        result.map { "长度:\(($0 as! String).count)" }
            .emit(to: self.label.rx.text)
            .disposed(by: disposeBag)
        // 绑定到button上面
        result.map { ($0 as! String) }
            .emit(to: self.btn.rx.title())
            .disposed(by: disposeBag)
    }
    
    
    func dealwithData(inputText:String)->Observable<Any>{
        print("请求网络了")
        return Observable<Any>.create({ (ob) -> Disposable in
            if inputText == "1234" {
                ob.onError(NSError.init(domain: "com.lgcooci.cn", code: 10086, userInfo: nil))
            }
            ob.onNext("已经输入:\(inputText)")
            ob.onCompleted()
            return Disposables.create()
        })
    }
    

}
