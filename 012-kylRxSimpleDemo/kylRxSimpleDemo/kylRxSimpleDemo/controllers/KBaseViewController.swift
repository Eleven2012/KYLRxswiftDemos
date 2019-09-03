//
//  KBaseViewController.swift
//  kylRxSimpleDemo
//
//  Created by yulu kong on 2019/8/30.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
//import RxDataSources

class KBaseViewController: UIViewController {

    let disposeBag = DisposeBag()
    var resuseID : String {
        get{
            return "resuseID_\(NSStringFromClass(self.classForCoder))"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNav()
        self.setupUI()
        print("************** \(self.classForCoder) 显示完毕**************")
    }
    
    func setupNav(){}
    
    func setupUI() {
        self.view.backgroundColor = UIColor.white
    }
    
    /// 页面发生析构
    deinit {
        print("************** \(self.classForCoder) 控制器走了**************")
    }

}
