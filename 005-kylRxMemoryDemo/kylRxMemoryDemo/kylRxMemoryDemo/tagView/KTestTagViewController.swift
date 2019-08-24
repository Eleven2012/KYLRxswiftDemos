//
//  KTestTagViewController.swift
//  kylRxMemoryDemo
//
//  Created by yulu kong on 2019/8/22.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit
import SnapKit

class KTestTagViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        setupUI()
    }
    
    
    fileprivate let tagsField = KYLTagsField()
    
    private lazy var tagsView:UIView = {
       let v = UIView(frame: view.bounds)
       return v
    }()
    
    private lazy var newTagTextField:UITextField = {
       let t = UITextField(frame: CGRect.zero)
        //t.borderStyle = .roundRect
       return t
    }()
    
    
    private  lazy var btnAddMore:UIButton = {
       let btn = UIButton(type: .custom)
       btn.setTitle("添加", for: .normal)
        btn.addTarget(self, action: #selector(btnAddMoreClicked(_:)), for: .touchUpInside)
       return btn
    }()
    
    private  lazy var btnChangeStyle:UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("改变样式", for: .normal)
        btn.addTarget(self, action: #selector(btnChangeStyleClicked(_:)), for: .touchUpInside)
        return btn
    }()
    
    
    private  lazy var btnRead:UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("只读", for: .normal)
        btn.addTarget(self, action: #selector(btnReadClicked(_:)), for: .touchUpInside)
        return btn
    }()
    
    private  lazy var btnShowTable:UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("显示列表", for: .normal)
        btn.addTarget(self, action: #selector(btnShowListClicked(_:)), for: .touchUpInside)
        return btn
    }()

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension KTestTagViewController {
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tagsView)
        view.addSubview(btnAddMore)
        view.addSubview(btnChangeStyle)
        view.addSubview(btnRead)
        view.addSubview(btnShowTable)
        view.addSubview(newTagTextField)
        
        tagsView.backgroundColor = .red
        tagsView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(view.bounds.height/4)
        }
        
        btnAddMore.backgroundColor = .green
        btnAddMore.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.top.equalTo(tagsView.snp.bottom).offset(50)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
        btnChangeStyle.backgroundColor = .green
        btnChangeStyle.snp.makeConstraints { (make) in
            make.left.equalTo(btnAddMore.snp.right).offset(10)
            make.top.equalTo(btnAddMore)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
        btnRead.backgroundColor = .green
        btnRead.snp.makeConstraints { (make) in
            make.left.equalTo(btnChangeStyle.snp.right).offset(10)
            make.top.equalTo(btnChangeStyle)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
        btnShowTable.backgroundColor = .green
        btnShowTable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.top.equalTo(btnAddMore.snp.bottom).offset(15)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
        newTagTextField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.top.equalTo(btnShowTable.snp.bottom).offset(30)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        
        setupTagFieldView()
        
    }
    
    private func setupTagFieldView() {
        tagsView.addSubview(tagsField)
        tagsField.snp.makeConstraints { (make) in
            make.edges.equalTo(tagsView)
        }
        tagsField.cornerRadius = 3.0
        tagsField.spaceBetweenLines = 10
        tagsField.spaceBetweenTags = 10
        
        //tagsField.numberOfLines = 3
        //tagsField.maxHeight = 100.0
        
        tagsField.layoutMargins = UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)
        tagsField.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) //old padding
        
        tagsField.placeholder = "Enter a tag"
        tagsField.placeholderColor = .red
        tagsField.placeholderAlwaysVisible = true
        tagsField.backgroundColor = .lightGray
        tagsField.returnKeyType = .next
        tagsField.delimiter = ""
        tagsField.keyboardAppearance = .dark
        
        tagsField.textDelegate = self
        //tagsField.acceptTagOption = .space
        
        textFieldEvents()
    }
}

// MARK: -点击事件
extension KTestTagViewController {
    
    @objc private func btnAddMoreClicked(_ sender: Any) {
        debugPrint("\(#function)")
        //tagsField.beginEditing()
        tagsField.addTag(NSUUID().uuidString)
        tagsField.addTag(NSUUID().uuidString)
        tagsField.addTag(NSUUID().uuidString)
        tagsField.addTag(NSUUID().uuidString)
    }
    
    @objc private func btnChangeStyleClicked(_ sender: Any) {
        debugPrint("\(#function)")
        tagsField.layoutMargins = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        tagsField.contentInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2) //old padding
        tagsField.cornerRadius = 10.0
        tagsField.spaceBetweenLines = 2
        tagsField.spaceBetweenTags = 2
        tagsField.tintColor = .red
        tagsField.textColor = .blue
        tagsField.selectedColor = .yellow
        tagsField.selectedTextColor = .black
        tagsField.delimiter = ","
        tagsField.isDelimiterVisible = true
        tagsField.borderWidth = 2
        tagsField.borderColor = .blue
        tagsField.fieldTextColor = .green
        tagsField.placeholderColor = .green
        tagsField.placeholderAlwaysVisible = false
        tagsField.font = UIFont.systemFont(ofSize: 9)
    }
    
    
    @objc private func btnReadClicked(_ sender: Any) {
        debugPrint("\(#function)")
        tagsField.readOnly = !tagsField.readOnly
        guard let button = sender as? UIButton else {
            return
        }
        button.isSelected = tagsField.readOnly
    }
    
    @objc private func btnShowListClicked(_ sender: Any) {
        debugPrint("\(#function)")
        navigationController?.pushViewController(KTestTagTableVC(), animated: true)
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        tagsField.endEditing()
    }
}

extension KTestTagViewController {
    
    fileprivate func textFieldEvents() {
        tagsField.onDidAddTag = { field, tag in
            print("onDidAddTag", tag.text)
        }
        
        tagsField.onDidRemoveTag = { field, tag in
            print("onDidRemoveTag", tag.text)
        }
        
        tagsField.onDidChangeText = { _, text in
            print("onDidChangeText")
        }
        
        tagsField.onDidChangeHeightTo = { _, height in
            print("HeightTo \(height)")
        }
        
        tagsField.onDidSelectTagView = { _, tagView in
            print("Select \(tagView.displayText)")
        }
        
        tagsField.onDidUnselectTagView = { _, tagView in
            print("Unselect \(tagView.displayText)")
        }
    }
    
}

extension KTestTagViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == tagsField {
            //anotherField.becomeFirstResponder()
            newTagTextField.becomeFirstResponder()
        }
        return true
    }
    
}
