//
//  KRxHigherFunctionTestVC.swift
//  kylRxSimpleDemo
//
//  Created by yulu kong on 2019/9/3.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class KRxHigherFunctionTestVC: KBaseViewController {
    
    var data = KRxTestGithubData()
    var data2 = KRxTestSectionGithubData()
    
    /// tableView懒加载
    lazy var tableView: UITableView = {
        let tabView = UITableView.init(frame: self.view.bounds, style: .plain)
        tabView.tableFooterView = UIView()
        tabView.register(KRxFuntionItemCell.classForCoder(), forCellReuseIdentifier: resuseID)
        tabView.rowHeight = 80
        
        return tabView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        super.setupUI()
        /// 加载tableView
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
}

extension KRxHigherFunctionTestVC {
    /// Rx 处理分组
    func setupTableViewRX() {
        
        let tableViewDataSource = RxTableViewSectionedReloadDataSource<SectionModel<String,KRxTestSectionModel>>(configureCell: { [weak self](dataSource, tab, indexPath, model) -> KRxFuntionItemCell in
            
            let cell = tab.dequeueReusableCell(withIdentifier: self?.resuseID ?? "resuseID_LGSectionViewController", for: indexPath) as! KRxFuntionItemCell
            cell.setUISectionData(model)
            cell.selectionStyle = .none
            return cell
            },titleForHeaderInSection: { dataSource,index -> String in
                 debugPrint("数据:\(dataSource.sectionModels[index].identity)")
                return dataSource.sectionModels[index].model
        })
        
        /// 我们上次就是通过bind函数,这里我们变化一下
        self.data.githubData.asDriver(onErrorJustReturn: [])
            .drive(self.tableView.rx.items(dataSource: tableViewDataSource))
            .disposed(by: self.disposeBag)
        
    }
    
}


