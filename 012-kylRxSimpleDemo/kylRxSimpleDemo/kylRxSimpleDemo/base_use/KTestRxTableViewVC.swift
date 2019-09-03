//
//  KTestRxTableViewVC.swift
//  kylRxSimpleDemo
//
//  Created by yulu kong on 2019/9/3.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class KTestRxTableViewVC: KBaseViewController {

    /// tableView懒加载
    lazy var tableView: UITableView = {
        let tabView = UITableView.init(frame: self.view.bounds, style: .plain)
        tabView.tableFooterView = UIView()
        tabView.register(KFunItemCell.classForCoder(), forCellReuseIdentifier: resuseID)
        tabView.rowHeight = 80
        
        return tabView
    }()
    
    //歌曲列表数据源
    let musicListViewModel = MusicListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNav()
        self.customSectionModel()
    }
    
    /// 导航栏相关
    override func setupNav() {
        self.title = "基础使用篇--实例2.1"
        self.view.backgroundColor = UIColor.white
        /// 加载tableView
        self.view.addSubview(self.tableView)
    }
    
    
    /// 自定义组模型
    func customSectionModel() {
        //将数据源数据绑定到tableView上
        musicListViewModel.data
            .bind(to: tableView.rx.items(cellIdentifier:"musicCell")) { _, music, cell in
                cell.textLabel?.text = music.name
                cell.detailTextLabel?.text = music.singer
            }.disposed(by: disposeBag)
        
        //tableView点击响应
        tableView.rx.modelSelected(Music.self).subscribe(onNext: { music in
            print("你选中的歌曲信息【\(music)】")
        }).disposed(by: disposeBag)
    }
}
