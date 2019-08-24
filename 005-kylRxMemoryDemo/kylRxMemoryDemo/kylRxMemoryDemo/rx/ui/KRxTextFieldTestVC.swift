//
//  KRxTextFieldTestVC.swift
//  kylRxMemoryDemo
//
//  Created by yulu kong on 2019/8/24.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

fileprivate let minUsernameLength = 5
fileprivate let minPasswordLength = 6

class KRxTextFieldTestVC: UIViewController {

    @IBOutlet weak var usernameTextFiled: UITextField!
    @IBOutlet weak var usernameValidLabel: UILabel!
    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBOutlet weak var passwordValidLabel: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    
    var disposeBag = DisposeBag.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /**
         * 当用户输入用户名时，如果用户名不足 5个字就给出红色提示语，并且无法输入密码，当用户名符合要求时才可以输入密码。
         
         * 同样的当用户输入的密码不到 5 个字时也给出红色提示语。 当用户名和密码有一个不符合要求时底部的绿色按钮不可点击，只有当用户名和密码同时有效时按钮才可点击。
         
         * 当点击绿色按钮后弹出一个提示框，这个提示框只是用来做演示而已。
         */
        
        // usernameTextFiled.rx.text序列 - usernameVaild 序列
        let usernameVaild = usernameTextFiled.rx.text.orEmpty
            .map { (text) -> Bool in
                return text.count >= minUsernameLength
        }
        // 绑定到我们验证显示
        usernameVaild.bind(to: usernameValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        usernameVaild.bind(to: passwordTextFiled.rx.isEnabled)
            .disposed(by: disposeBag)
        
        let passwordVaild = passwordTextFiled.rx.text.orEmpty
            .map { (text) -> Bool in
                return text.count >= minPasswordLength
        }
        passwordVaild.bind(to: passwordValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        // 决定按钮 - button.rx.isenable
        Observable.combineLatest(usernameVaild,passwordVaild) { $0 && $1}
            .bind(to: loginBtn.rx.isEnabled)
            .disposed(by: disposeBag)
        
        loginBtn.rx.tap.subscribe(onNext: { () in
            print("dianji")
        }).disposed(by: disposeBag)
        
        
    }


}
