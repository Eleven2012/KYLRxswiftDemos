//
//  RxSecondViewController.swift
//  kylRxMemoryDemo
//
//  Created by yulu kong on 2019/8/22.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit

class RxSecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnTestCircleRetain(_ sender: Any) {
        navigationController?.pushViewController(KCHomeViewController(), animated: true)
    }
    
    @IBAction func btnTagClicked(_ sender: Any) {
        self.navigationController?.pushViewController(KTestTagViewController(), animated: true)
    }


    @IBAction func btnTestBinder(_ sender: Any) {
        navigationController?.pushViewController(KCTestBinderVC(), animated: true)
    }
    
    @IBAction func btnTestTable(_ sender: Any) {
        navigationController?.pushViewController(KTVTestVC(), animated: true)
    }
    
    @IBAction func btnTestUI1(_ sender: Any) {
        navigationController?.pushViewController(KRxTextFieldTestVC(), animated: true)
    }
    
}
