//
//  KRxTableViewEditTestVC.swift
//  kylRxSimpleDemo
//
//  Created by yulu kong on 2019/9/3.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit
import RxSwift

class KRxTableViewEditTestVC: KBaseViewController {
    
    /// tableView懒加载
    lazy var tableView: UITableView = {
        let tabView = UITableView.init(frame: self.view.bounds, style: .plain)
        tabView.tableFooterView = UIView()
        tabView.delegate = self
        tabView.register(KPersonTableViewCell.classForCoder(), forCellReuseIdentifier: resuseID)
        return tabView
    }()
    
    var array = Array<Any>()
    var style = UITableViewCell.EditingStyle.delete
    let viewModel = LGViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNav()
        self.setupTableViewRX()
    }
    
    /// 导航栏相关
    override func setupNav() {
        self.title = "编辑TableView"
        self.view.backgroundColor = UIColor.white
        /// 加载tableView
        self.view.addSubview(self.tableView)
        
        /// 编辑样式(删除-新增)按钮
        let editStyleButton = UIButton.init(type: .custom)
        editStyleButton.setTitle("删除", for: .normal)
        editStyleButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        editStyleButton.setTitleColor(UIColor.red, for: .normal)
        editStyleButton.addTarget(self, action: #selector(didClickRightItemAction(sender:)), for: .touchUpInside)
        let editStyleItem = UIBarButtonItem(customView: editStyleButton)
        
        /// 开启编辑按钮
        let editButton = UIButton.init(type: .custom)
        editButton.setTitle("编辑", for: .normal)
        editButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        editButton.setTitleColor(UIColor.blue, for: .normal)
        editButton.addTarget(self, action: #selector(didClickRightItemAction(sender:)), for: .touchUpInside)
        let editItem = UIBarButtonItem(customView: editButton)
        
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        barButtonItem.width = -5
        
        self.navigationItem.rightBarButtonItems = [editStyleItem,editItem,barButtonItem]
        
    }
    
    /// tableView -- RX
    func setupTableViewRX() {
        let dataOB = BehaviorSubject.init(value: self.viewModel.dataArray)
        // 骚起来
        //        dataOB.bind(to: self.tableView.rx.items){(tabView,row,model) ->LGTableViewCell in
        //            let cell = tabView.dequeueReusableCell(withIdentifier: resuseID) as! LGTableViewCell
        //            cell.setUIData(model as! LGModel)
        //            return cell
        //        }.disposed(by: disposeBag)
        
        dataOB.asObserver().bind(to: self.tableView.rx.items(cellIdentifier: resuseID, cellType: KPersonTableViewCell.self)){
            (row,model,cell) in
            cell.setUIData(model as! LGModel)
            }.disposed(by: self.disposeBag)
        
        // tableView点击事件
        tableView.rx.itemSelected.subscribe(onNext: { [weak self](indexPath) in
            print("点击\(indexPath)行")
            self?.navigationController?.pushViewController(LGSectionViewController(), animated: true)
            self?.tableView.deselectRow(at: indexPath, animated: true)
        }).disposed(by: self.disposeBag)
        
        // tableView复选点击事件
        tableView.rx.itemDeselected.subscribe(onNext: { (indexPath) in
            print("再次点击\(indexPath)行")
        }).disposed(by: self.disposeBag)
        
        // tableView移动事件
        tableView.rx.itemMoved.subscribe(onNext: { [weak self] (sourceIndex,destinationIndex) in
            print("从\(sourceIndex)移动到\(destinationIndex)")
            self?.viewModel.dataArray.swapAt(sourceIndex.row, destinationIndex.row)
            self?.loadUI(obSubject: dataOB)
        }).disposed(by: self.disposeBag)
        
        // tableView删除事件
        tableView.rx.itemDeleted.subscribe(onNext: { [weak self](indexPath) in
            print("点击删除\(indexPath)行")
            self?.viewModel.dataArray.remove(at: indexPath.row)
            self?.loadUI(obSubject: dataOB)
        }).disposed(by: self.disposeBag)
        
        // tableView新增事件
        tableView.rx.itemInserted.subscribe(onNext: { [weak self](indexPath) in
            print("添加数据在\(indexPath)行")
            guard let model = self?.viewModel.dataArray.last else{
                print("数据有问题,无法新增")
                return
            }
            self?.viewModel.dataArray.insert(model, at: indexPath.row)
            self?.loadUI(obSubject: dataOB)
        }).disposed(by: self.disposeBag)
        
        
        //        self.viewModel.rx.observeWeakly(Array<Any>.self, "dataArray")
        //            .subscribe({ (arr) in
        //                dataOB.onNext(arr ?? [])
        //            }).disposed(by: self.disposeBag)
        
    }
    
    func loadUI(obSubject:BehaviorSubject<[Any]>) {
        obSubject.onNext(self.viewModel.dataArray)
    }
    
    @objc func didClickRightItemAction(sender:UIButton){
        
        if sender.currentTitle == "删除" {
            self.style = UITableViewCell.EditingStyle.insert
            sender.setTitle("新增", for: .normal)
        }else if sender.currentTitle == "新增" {
            self.style = UITableViewCell.EditingStyle.delete
            sender.setTitle("删除", for: .normal)
        }else if sender.currentTitle == "编辑" {
            self.tableView.isEditing = true
            sender.setTitle("关闭", for: .normal)
        }else{
            self.tableView.isEditing = false
            sender.setTitle("编辑", for: .normal)
        }
    }
    
}

extension KRxTableViewEditTestVC:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return self.style
    }
}
