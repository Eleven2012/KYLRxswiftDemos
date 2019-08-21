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
    let person: KPerson = KPerson()
    
    fileprivate var mySubject = PublishSubject<Any>()
    var publicOB : Observable<Any>{
        mySubject = PublishSubject<Any>()
        return mySubject.asObservable()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //print("\(#function)*****KCDetailViewController出现了:RxSwift的引用计数: \(RxSwift.Resources.total)")
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
    }
    
    @objc func didClickRightItem(){
        self.navigationController?.pushViewController(KCTableViewController(), animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        mySubject.onNext("Cooci")
    }
    
    deinit {
        print("\(self)走了 ")
    }
}
