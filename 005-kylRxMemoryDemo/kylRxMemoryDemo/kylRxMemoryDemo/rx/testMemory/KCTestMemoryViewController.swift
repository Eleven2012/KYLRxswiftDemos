//
//  KCTestMemoryViewController.swift
//  kylRxMemoryDemo
//
//  Created by yulu kong on 2019/8/24.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class KCTestMemoryViewController: UIViewController {

    lazy var accountTF: UITextField = {
        let tf = UITextField(frame: CGRect(x: 100, y: 200, width: 200, height: 30))
        tf.borderStyle = .roundedRect
        tf.backgroundColor = UIColor.lightText
        return tf
    }()
    
    var name:String?
    var myClosure : (() -> Void)?
    var number: Int? = nil
    let disposeBag = DisposeBag()
    var observer: AnyObserver<Any>?
    var observable: Observable<Any>?
    let vc = KCDetailViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "内存管理测试页面"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.accountTF)
        
        //         retainCycleDemo()
        rxRetainCycleDemo1()
        // rxRetainCycleDemo2()
        // rxRetainCycleDemo3()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        let vc = LGDetialViewController()
        _ = vc.publicOB
            .subscribe(onNext: { (item) in
                print("订阅到 \(item)")
            })
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func rxRetainCycleDemo3(){
        
        // create -> self
        // create -> self -> anyObserver -> observer -> AnonymousObservableSink.on
        // -> AnonymousObserver.on -> onNext?(value) -> subscribe{} -> self
        
        // self -> observer -> AnyObserver
        // subscribe -> AnonymousObserver
        
        Observable<Any>.create { (anyObserver) -> Disposable in
            self.observer = anyObserver
            anyObserver.onNext("Hello word")
            return Disposables.create()
            }
            .subscribe(onNext: { (item) in
                print(self)
                print("订阅到:\(item)")
            })
            .disposed(by: self.disposeBag)
    }
    
    func rxRetainCycleDemo2(){
        
        // 持有序列 - create
        // self -> observable -> create{} -> self
        self.observable = Observable<Any>.create { (anyObserver) -> Disposable in
            anyObserver.onNext("Hello word")
            return Disposables.create()
        }
        
        // 持有序列 - 订阅
        // self -> observable -> subscribe onNext -> self
        self.observable?.subscribe(onNext: {
            print(self)
            print("订阅到1:\($0) --")
        })
            .disposed(by: self.disposeBag)
        
    }
    
    func rxRetainCycleDemo1() {
        
        //        self.accountTF.rx.text.orEmpty
        //            .debug()
        //            .subscribe(onNext: { [weak self](text) in
        //                self?.title = text
        //            })
        //            .disposed(by: disposeBag)
        
        self.accountTF.rx.text.orEmpty
            .bind(to: self.rx.title)
            .disposed(by: disposeBag)
        
    }
    
    func retainCycleDemo() {
        
        UIView.animate(withDuration: 1) {
            print(self)
        }
        
        // self -> myClosure -> {}  -> self  -释放不掉
        //        myClosure = {[weak self] in
        //            // weak - strong - dance
        //            guard let self = self else { return }
        //            DispatchQueue.global().asyncAfter(deadline: .now()+2, execute: {
        //                self.name = "Cooci"
        //                print(self.name)
        //            })
        //        }
        //        self.myClosure!()
    }
    
    deinit {
        print("\(self)走了 ")
    }

}
