//
//  KCHomeViewController.swift
//  kyl_DSBrigeDemo
//
//  Created by yulu kong on 2019/8/21.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit
import RxSwift


class KCHomeViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("\(#function)*****首页控制器出现了show:RxSwift的引用计数: \(RxSwift.Resources.total)")
        print("****************************************")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("\(#function)*****首页控制器消失了dismiss:RxSwift的引用计数: \(RxSwift.Resources.total)")
        print("****************************************")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .gray
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print("\(#function)*****首页控制touchesBegan:RxSwift的引用计数: \(RxSwift.Resources.total)")
        print("****************************************")
        
        let vc = KCTestMemoryViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
