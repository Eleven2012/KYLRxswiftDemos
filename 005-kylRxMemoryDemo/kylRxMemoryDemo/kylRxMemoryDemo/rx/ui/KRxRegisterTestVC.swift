//
//  KRxRegisterTestVC.swift
//  kylRxMemoryDemo
//
//  Created by yulu kong on 2019/8/24.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

enum LGGender {
    case notSelcted
    case male
    case female
}



class KRxRegisterTestVC: UIViewController {

    @IBOutlet weak var birthdayPicker: UIDatePicker!
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var femaleBtn: UIButton!
    @IBOutlet weak var knowSwiftSwitch: UISwitch!
    @IBOutlet weak var swiftLevelSlider: UISlider!
    @IBOutlet weak var passionToLearnStepper: UIStepper!
    @IBOutlet weak var heartHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var updateBtn: UIButton!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.birthdayPicker.layer.borderWidth = 1
        // 首先我们的出生日期不能早于今天,否则边框变色
        let birthdayOB = birthdayPicker.rx.date
            .map { KDataPickerValidator.isValidDate(date: $0) }
        
        // 背景色
        birthdayOB.map { $0 ? UIColor.orange : UIColor.clear}
            .subscribe(onNext: { (color) in
                self.birthdayPicker.layer.borderColor = color.cgColor
            })
            .disposed(by: disposeBag)
        // 接下来我们处理性别选择
        // 现在我们想象性别选择按钮的背后的逻辑
        // 1 : 性别的选择 和 上面生日的选择 决定下面更新按钮 : 我们常见的必选项
        // 2 : 性别的选择 是由我们的两个按钮的处理,我们没必要分开逻辑
        
        let genderSelectOB = Variable<LGGender>(.notSelcted)
        maleBtn.rx.tap
            .map{ LGGender.male } // 男生的序列
            .bind(to: genderSelectOB) // 绑定到我们定义的序列
            .disposed(by: disposeBag)
        
        femaleBtn.rx.tap
            .map{ LGGender.female } // 男生的序列
            .bind(to: genderSelectOB) // 绑定到我们定义的序列
            .disposed(by: disposeBag)
        
        genderSelectOB.asObservable().subscribe(onNext: { (gender) in
            switch gender {
            case .male:
                self.maleBtn.setImage(UIImage(named: "check"), for: .normal)
                self.femaleBtn.setImage(UIImage(named: "uncheck"), for: .normal)
            case .female:
                self.femaleBtn.setImage(UIImage(named: "check"), for: .normal)
                self.maleBtn.setImage(UIImage(named: "uncheck"), for: .normal)
            default:
                break;
            }
        })
            .disposed(by: disposeBag)
        
        
        // 按钮点击 - 常规思维就是给一个变量记录
        // Rx思维 应该是绑定到相应的序列里面去
        // 这样的序列就是我们的 genderSelectionOb : male female male ...枚举的值
        
        let genderSELOB = genderSelectOB.asObservable().map { $0 != .notSelcted ? true : false }
        // 控制我们的点击更新按钮 - 被两个序列共同影响
        Observable.combineLatest(birthdayOB,genderSELOB) { $0 && $1}
            .bind(to: updateBtn.rx.isEnabled)
            .disposed(by: disposeBag)
        
        
        // 接下来 我们来玩玩其他控件
        /**
         对于UISwitch来说：
         
         当UISwitch为OFF时，表示用户不了解Swift，因此，下面的UISlider应该为0；
         当UISwitch为ON时，可以默认把UISlider设置在1/4的位置，表示大致了解；
         
         对于UISlider来说：
         
         当UISlider不为0时，应该自动把UISwitch设置为ON；
         当UISlider为0时，应该自动把UISwitch设置为OFF；
         */
        
        // on off  -> 0.25  0
        knowSwiftSwitch.rx.value.map { $0 ? 0.25 : 0}
            .bind(to: swiftLevelSlider.rx.value)
            .disposed(by: disposeBag)
        
        // 0  1 true false
        swiftLevelSlider.rx.value.map { $0 != 0 ? true : false}
            .bind(to: knowSwiftSwitch.rx.isOn)
            .disposed(by: disposeBag)
        
        passionToLearnStepper.rx.value.skip(1).subscribe(onNext: { (value) in
            self.heartHeightConstraint.constant = CGFloat(value - 10)
        }).disposed(by: disposeBag)
        
    }
}
