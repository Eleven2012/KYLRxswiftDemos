//
//  KCDetailViewController.swift
//  kyl_DSBrigeDemo
//
//  Created by yulu kong on 2019/8/21.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


class KCDetailViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    var observer: AnyObserver<Any>?
    let person: LGPerson = LGPerson()
    
    fileprivate var mySubject = PublishSubject<Any>()
    var publicOB : Observable<Any>{
        mySubject = PublishSubject<Any>()
        return mySubject.asObservable()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("*****LGDetialViewController出现了:RxSwift的引用计数: \(RxSwift.Resources.total)")
        print("****************************************")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mySubject.onCompleted()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页详情页面"
        self.view.backgroundColor = UIColor.lightGray
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(didClickRightItem))
        
        person.rx.observe(String.self, "name")
            .subscribe(onNext: { (text) in
                print("text = \(String(describing: text))")
            }, onError: { (error) in
                print("订阅到了错误:\(error)")
            }, onCompleted: {
                print("完成了")
            }) {
                print("销毁了")
            }
            .disposed(by: disposeBag)
        
        rx.deallocating
        
        rx.deallocated
        
    }
    
    @objc func didClickRightItem(){
        self.navigationController?.pushViewController(KCTableViewController(), animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /// mySubject.onNext("Cooci")
        print("*****LGDetialViewController:touchesBegan:RxSwift的引用计数: \(RxSwift.Resources.total)")
        print("****************************************")
        
    }
    
    deinit {
        print("\(self)走了 ")
    }
}
