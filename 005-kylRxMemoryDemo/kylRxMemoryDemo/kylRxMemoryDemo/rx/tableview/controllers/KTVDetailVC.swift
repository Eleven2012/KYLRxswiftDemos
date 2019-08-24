//
//  KTVDetailVC.swift
//  kylRxMemoryDemo
//
//  Created by yulu kong on 2019/8/24.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class KTVDetailVC: UITableViewController {
    
    @IBOutlet weak var todoNameTF: UITextField!
    @IBOutlet weak var isFinishedSwitch: UISwitch!
    @IBOutlet weak var choosePictureBtn: UIButton!
    var done: Bool = false
    
    fileprivate let todoSubject = PublishSubject<LGModel>()
    var todoOB: Observable<LGModel>{
        return todoSubject.asObservable()
    }
    let disposBag = DisposeBag()
    
    var model: LGModel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        todoNameTF.becomeFirstResponder()
        
        if let model = model {
            todoNameTF.text = model.tittle
            isFinishedSwitch.isOn = model.isFinished
        }
        else {
            model = LGModel(tittle: "", isFinished: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        done = false
    }
    
    func setupUI() {
        self.title = "新增待办事项详情"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(didClickDoneAction))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .cancel, target: self, action: #selector(didClickCancelAction))
        
        _ = self.choosePictureBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.navigationController?.pushViewController(LGPhotoCollectionViewController(), animated: true)
        })
    }
    
    
    @objc func didClickCancelAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didClickDoneAction() {
        
        model.tittle = todoNameTF.text ?? ""
        model.isFinished = isFinishedSwitch.isOn
        todoSubject.onNext(model)
        
        self.navigationController?.popViewController(animated: true)
    }
    
}

//extension LGDetailViewController {
//    fileprivate func getDocumentsDir() -> URL {
//        return FileManager.default.urls(
//            for: .documentDirectory,
//            in: .userDomainMask)[0]
//    }
//
//    // 重置按钮
//    fileprivate func resetMemoBtn() {
//        choosePictureBtn.setBackgroundImage(nil, for: .normal)
//        choosePictureBtn.setTitle("点击,选择你报备忘的相片", for: .normal)
//    }
//
//    // 设置按钮背景图片
//    fileprivate func setMemoBtn(bkImage: UIImage) {
//        choosePictureBtn.setBackgroundImage(bkImage, for: .normal)
//        choosePictureBtn.setTitle("", for: .normal)
//    }
//
//    // 保存图片
//    fileprivate func savePictureMemos() -> String {
//
//        if let todoCollectedImage = self.todoCollectedImage,
//            let data = todoCollectedImage.pngData() {
//            let path = getDocumentsDir()
//            let filename = self.todoNameTF.text! + UUID().uuidString + ".png"
//            let memoImageUrl = path.appendingPathComponent(filename)
//
//            try? data.write(to: memoImageUrl)
//            return filename
//        }
//
//        return self.model.pictureMemo
//    }
//}
