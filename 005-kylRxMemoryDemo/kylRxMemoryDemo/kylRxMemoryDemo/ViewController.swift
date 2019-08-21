//
//  ViewController.swift
//  kylRxMemoryDemo
//
//  Created by yulu kong on 2019/8/21.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("\(#function)*****KCDetailViewController出现了:RxSwift的引用计数: \(RxSwift.Resources.total)")
    }


}

