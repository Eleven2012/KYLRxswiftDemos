//
//  KAddPersonVC.swift
//  kylWCDBSwiftDemo
//
//  Created by yulu kong on 2019/9/10.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit
import SVProgressHUD

class KAddPersonVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        nameField.text = person?.name
        sexField.text = person?.sex
        ageField.text = "\(person?.age ?? 0)"
    }
    

    /// 此控制器的编辑类型
    ///
    /// - edit: 修改
    /// - add: 新增
    enum PersonEditType {
        case edit
        case add
    }
    
    var editType: PersonEditType = .add
    var person: KPerson?
    
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var sexField: UITextField!
    @IBOutlet weak var nameField: UITextField!

}

extension KAddPersonVC {
    @IBAction func confirmAction(_ sender: UIButton) {
        
        guard let name = nameField.text,
            let sex = sexField.text,
            let ageText = ageField.text,
            let age = Int(ageText) else {
                
                return
        }
        let p = person ?? KPerson()
        p.name = name
        p.sex = sex
        p.age = age
        if editType == .add {
            //数据库中新增一个人物
            KDBManager.share.insertToDb(objects: [p], intoTable: TB_Person)
            SVProgressHUD.showSuccess(withStatus: "添加成功!")
        }
        else if editType == .edit {
            //修改一个数据库中的人物
            
            KDBManager.share.update(table: TB_Person,
                                    on: KPerson.Properties.all,
                                    with: p,
                                    where: KPerson.Properties.id )
            SVProgressHUD.showSuccess(withStatus: "修改成功!")
        }
    }
    
    @IBAction func clearAction(_ sender: UIButton) {
        nameField.text = ""
        sexField.text = ""
        ageField.text = ""
    }
}
