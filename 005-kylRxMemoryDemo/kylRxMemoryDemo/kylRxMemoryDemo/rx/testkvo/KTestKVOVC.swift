//
//  KTestKVOVC.swift
//  kylRxMemoryDemo
//
//  Created by yulu kong on 2019/8/24.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class KTestKVOVC: UIViewController {

    let person = LGPerson()
    var disposeBag = DisposeBag()
    
    var name: String = ""{
        willSet{
            print(newValue)
        }
        didSet{
            print(oldValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        
        //        self.person.rx.observe(String.self, "name").subscribe(onNext: { (change) in
        //                print("observe订阅到了KVO:\(String(describing: change))")
        //            }).disposed(by: disposeBag)
        
        //        person.addObserver(self, forKeyPath: "name", options: .new, context: nil)
        
        // 序列
        self.person.rx.observeWeakly(String.self, "name")
            .subscribe(onNext: { (change) in
                print("observeWeakly订阅到了KVO:\(String(describing: change))")
            })
            .disposed(by: disposeBag)
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    }
    
    deinit {
        person.removeObserver(self, forKeyPath: "name")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.person.name.append("++")
        self.person.age.append("+")
        
        self.name.append("+")
    }
}
