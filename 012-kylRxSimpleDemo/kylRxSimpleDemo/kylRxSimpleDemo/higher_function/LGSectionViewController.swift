//
//  LGSectionViewController.swift
//  003-RxCocoa-TableView
//
//  Created by Cooci on 2019/6/15.
//  Copyright © 2019 LGCooci. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources
//import JXPhotoBrowser

class LGSectionViewController: KBaseViewController {

    /// tableView懒加载
    lazy var tableView: UITableView = {
        let tabView = UITableView.init(frame: self.view.bounds, style: .plain)
        tabView.tableFooterView = UIView()
        tabView.register(KPersonTableViewCell.classForCoder(), forCellReuseIdentifier: resuseID)
        tabView.rowHeight = 80
        
        return tabView
    }()
    
    var data = LGGithubData()
    var data2 = LGSectionGithubData()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNav()
        self.setupTableViewRX()
    }
    
    /// 导航栏相关
    override func setupNav() {
        self.title = "分组VC梳理!!!"
        self.view.backgroundColor = UIColor.white
        /// 加载tableView
        self.view.addSubview(self.tableView)
    }
    
    /// Rx 处理分组
    func setupTableViewRX() {
        
        let tableViewDataSource = RxTableViewSectionedReloadDataSource<SectionModel<String,LGSectionModel>>(configureCell: { [weak self](dataSource, tab, indexPath, model) -> KPersonTableViewCell in

            let cell = tab.dequeueReusableCell(withIdentifier: self?.resuseID ?? "resuseID_LGSectionViewController", for: indexPath) as! KPersonTableViewCell
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
        let tableViewDataSource2 = RxTableViewSectionedReloadDataSource<LGSectionDataModel>(configureCell: { [weak self](dataSource, tab, indexPath, model) -> KPersonTableViewCell in
            
            let cell = tab.dequeueReusableCell(withIdentifier: self?.resuseID ?? "resuseID_LGSectionViewController", for: indexPath) as! KPersonTableViewCell
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

