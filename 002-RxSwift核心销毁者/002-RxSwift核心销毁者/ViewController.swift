//
//  ViewController.swift
//  002-RxSwift核心销毁者
//
//  Created by kongyulu on 2019/5/27.
//  Copyright © 2019 kongyulu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var startAction: UIButton!
    @IBOutlet weak var stopAction: UIButton!
    @IBOutlet weak var showSencondNum: UILabel!
    
    var intervalOB: Observable<Int>!
    var disposeSub: Disposable!
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 //        limitObservable()
//          intervalObservableTest()
        test_switchLatest()
    }
    
    
    deinit {
        print("我走了")
    }
}


// MARK: - Rx高阶函数： 映射操作符
extension ViewController {
    
}

// MARK: - Rx高阶函数： 组合操作符
extension ViewController {
    func test_startWith()  {
        // *** startWith : 在开始从可观察源发出元素之前，发出指定的元素序列
        print("*****startWith*****")
        Observable.of("1", "2", "3", "4")
            .startWith("A")
            .startWith("B")
            .startWith("C", "a", "b")
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        //效果: CabBA1234
        
    }
    
    func test_merge()  {
        // **** merge : 将源可观察序列中的元素组合成一个新的可观察序列，并将像每个源可观察序列发出元素一样发出每个元素
        print("*****merge*****")
        let subject1 = PublishSubject<String>()
        let subject2 = PublishSubject<String>()
        // merge
        Observable.of(subject1,subject2)
            .merge()
            .subscribe(onNext: { print($0)})
            .disposed(by: disposeBag)
        
        //- 下面任何一个响应都会勾起新序列响应
        subject1.onNext("K")
        subject1.onNext("o")
        subject2.onNext("n")
        subject2.onNext("g")
        subject1.onNext("Y")
        subject2.onNext("u")
        subject1.onNext("L")
        subject2.onNext("u")
    }
    
    func test_zip()  {
        //  *** zip: 将多达8个源可观测序列组合成一个新的可观测序列，并将从组合的可观测序列中发射出对应索引处每个源可观测序列的元素
        print("*****zip*****")
        let stringSubject = PublishSubject<String>()
        let intSubject = PublishSubject<Int>()
        
        Observable.zip(stringSubject, intSubject) { stringElement , intElement in
            "\(stringElement) \(intElement)"
        }
            .subscribe(onNext: {print($0)})
            .disposed(by: disposeBag)
        
        stringSubject.onNext("K")
        stringSubject.onNext("o") //到这里存储了K o 但是不好响应，除非有另一个响应
        
        intSubject.onNext(1) //勾出一个
        intSubject.onNext(2) //勾出另一个
        stringSubject.onNext("o") //再存一个
        intSubject.onNext(3) //勾出一个
        
        //总结： 只有两个序列同时有值的 时候才会响应，否则只会存值。
        
    }
    
    
    /// combineLatest:将8源可观测序列组合成一个新的观测序列,
    ///并将开始发出联合观测序列的每个源的最新元素可观测序列一旦所有排放源序列至少有一个元素,
    ///并且当源可观测序列发出的任何一个新元素
    func test_combineLatest()  {
        print("*****combineLatest*****")
        let stringSub =  PublishSubject<String>()
        let intSub = PublishSubject<Int>()
        //合并序列
        Observable.combineLatest(stringSub, intSub) { strE, intE in
            "\(strE) \(intE)"
        }
        .subscribe(onNext: {print($0)})
        .disposed(by: disposeBag)
        
        stringSub.onNext("K") //存一个K
        stringSub.onNext("Y") //存了一个覆盖 - 和zip不一样
        intSub.onNext(1) //发现strOB 观察者存在值 Y(上面的Y覆盖了K) 则 响应 Y 1
        intSub.onNext(2) //覆盖1 -> 2, 发现strOB有值YK 响应 Y 2
        stringSub.onNext("Kongyulu") // 覆盖Y -> Kongyulu 发现intOB有值 2 响应：Kongyulu 2
        
        //总结：1. combineLatest 比较zip 会覆盖
        // 2. 应用非常频繁: 比如账户和密码同时满足->才能登陆. 不关系账户密码怎么变化的只要查看最后有值就可以 loginEnable
    }
    
    
    
    // 将可观察序列发出的元素转换为可观察序列，并从最近的内部可观察序列发出元素
    func test_switchLatest()  {
        // switchLatest : 将可观察序列发出的元素转换为可观察序列，并从最近的内部可观察序列发出元素
        print("*****switchLatest*****")
        let switchLatestSub1 = BehaviorSubject(value: "K")
        let switchLatestSub2 = BehaviorSubject(value: "1")
        //注意下面这句代码：这里选择了switchLatestSub1就不会再监听switchLatestSub2
        let switchLatestSub = BehaviorSubject(value: switchLatestSub1)
        
        switchLatestSub.asObservable()
        .switchLatest()
        .subscribe(onNext: {print($0)})
        .disposed(by: disposeBag)
        
        switchLatestSub1.onNext("Y")
        switchLatestSub1.onNext("_")
        switchLatestSub2.onNext("2")
        switchLatestSub2.onNext("3") // 2,3都不会监听，但是默认保存有2 覆盖1  3覆盖2
        switchLatestSub.onNext(switchLatestSub2) //切换到 switchLatestSub2
        switchLatestSub1.onNext("*") //由于上面切换到了switchLatestSub2，所以switchLatestSub1不会响应，不会输出*
        switchLatestSub1.onNext("Kongyulu")//这里不会响应，不会输出Kongyulu
        switchLatestSub2.onNext("4")
        /*
         到这里会输出：
         *****switchLatest*****
         K
         Y
         _
         3
         4
         */
        switchLatestSub.onNext(switchLatestSub1)// 如果再次切换到 switchLatestSub1会打印出 Kongyulu
        switchLatestSub2.onNext("5")
        /*
         到这里会输出：
         *****switchLatest*****
         K
         Y
         _
         3
         4
         Kongyulu
         */
        
    }
}


// MARK: - 核心销毁者
extension ViewController {
    func limitObservable(){
        
        // 响应回来
        // 响应的简历
        //        self.addObserver(<#T##observer: NSObject##NSObject#>, forKeyPath: <#T##String#>, options: <#T##NSKeyValueObservingOptions#>, context: <#T##UnsafeMutableRawPointer?#>)
        
        // 创建序列
        let ob = Observable<Any>.create { (observer) -> Disposable in
            observer.onNext("Cooci")
            return Disposables.create { print("销毁释放了")} // dispose.dispose()
        }
        // 序列订阅
        let dispose = ob.subscribe(onNext: { (anything) in
            print("订阅到了:\(anything)")
        }, onError: { (error) in
            print("订阅到了:\(error)")
        }, onCompleted: {
            print("完成了")
        }) {
            print("销毁回调")
        }
        // 销毁关系
        // status - 算法 - dispose 随时随地都能销毁
        
        // 对象 是无法销毁的
        print("执行完毕")
        dispose.dispose()
    }
    
    func intervalObservableTest(){
        
        self.intervalOB = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.init())
        
        self.intervalOB.subscribe(onNext: { (num) in
            self.showSencondNum.text = String(num)
        }).disposed(by: disposeBag)
        
        _ = self.stopAction.rx.tap.subscribe(onNext: {
            print("点击按钮")
            self.disposeBag = DisposeBag()
        })
        
        
    }

}

