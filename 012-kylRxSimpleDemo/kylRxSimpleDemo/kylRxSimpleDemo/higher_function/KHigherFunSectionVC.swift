//
//  KHigherFunSectionVC.swift
//  kylRxSimpleDemo
//
//  Created by yulu kong on 2019/9/3.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources
//import JXPhotoBrowser

class KHigherFunSectionVC: KBaseViewController {
    
    /// tableView懒加载
    lazy var tableView: UITableView = {
        let tabView = UITableView.init(frame: self.view.bounds, style: .plain)
        tabView.tableFooterView = UIView()
        tabView.register(KFunItemCell.classForCoder(), forCellReuseIdentifier: resuseID)
        tabView.rowHeight = 80
        
        return tabView
    }()
    
    var data = KHighFunData()
    var data2 = KSectionHighFunData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNav()
        self.customSectionModel()
    }
    
    /// 导航栏相关
    override func setupNav() {
        self.title = "高阶函数"
        self.view.backgroundColor = UIColor.white
        /// 加载tableView
        self.view.addSubview(self.tableView)
    }
    
    /// Rx 处理分组
    func setupTableViewRX() {
        
        let tableViewDataSource = RxTableViewSectionedReloadDataSource<SectionModel<String,KFunItemSectionModel>>(configureCell: { [weak self](dataSource, tab, indexPath, model) -> KFunItemCell in
            
            let cell = tab.dequeueReusableCell(withIdentifier: self?.resuseID ?? "resuseID_LGSectionViewController", for: indexPath) as! KFunItemCell
            cell.setUISectionData(model)
            cell.selectionStyle = .none
            return cell
            },titleForHeaderInSection: { dataSource,index -> String in
                // print("数据:\(dataSource.sectionModels[index].identity)")
                return dataSource.sectionModels[index].model
        })
        
        /// 我们上次就是通过bind函数,这里我们变化一下
        self.data.githubData.asDriver(onErrorJustReturn: [])
            .drive(self.tableView.rx.items(dataSource: tableViewDataSource))
            .disposed(by: self.disposeBag)
        
    }
    
    /// 自定义组模型
    func customSectionModel() {
        let tableViewDataSource2 = RxTableViewSectionedReloadDataSource<KFunItemSectionDataModel>(configureCell: { [weak self](dataSource, tab, indexPath, model) -> KFunItemCell in
            
            let cell = tab.dequeueReusableCell(withIdentifier: self?.resuseID ?? "resuseID_LGSectionViewController", for: indexPath) as! KFunItemCell
            cell.setUISectionData(model)
            cell.selectionStyle = .none
            return cell
            },titleForHeaderInSection: { dataSource,index -> String in
                // print("数据:\(dataSource.sectionModels[index].identity)")
                return dataSource.sectionModels[index].lgheader
        })
        self.data2.sectionData.asDriver(onErrorJustReturn: [])
            .drive(self.tableView.rx.items(dataSource: tableViewDataSource2))
            .disposed(by: self.disposeBag)
        
    }
    
}
