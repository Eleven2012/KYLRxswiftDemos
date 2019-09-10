//
//  KPersonListTableVC.swift
//  kylWCDBSwiftDemo
//
//  Created by yulu kong on 2019/9/10.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit

import SVProgressHUD

let TB_Person = "tb_person"

class KPersonListTableVC: UITableViewController {
    
    private var dataArray: [KPerson]?
    
    /// 初始化一个searchbar
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        searchBar.delegate = self
        searchBar.placeholder = "输入想要搜索的名字"
        searchBar.setShowsCancelButton(true, animated: true)
        return searchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableHeaderView = searchBar
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        setupRefresh()
        
        //2.创建数据库表
        KDBManager.share.createTable(table: TB_Person, of: KPerson.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pulldownAction()
    }

    

}

extension KPersonListTableVC {
    /// 配置下拉刷新
    func setupRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pulldownAction), for: .valueChanged)
        tableView.addSubview(refreshControl)
        self.refreshControl = refreshControl
    }
    
    @objc func pulldownAction() {
        let text = searchBar.text ?? ""
        dataArray = searchFor(text)
        refreshControl?.endRefreshing()
        tableView.reloadData()
    }
    
    func searchFor(_ name: String = "") -> [KPerson]? {
        
        let persons: [KPerson]? = KDBManager.share.getObjects(on: KPerson.Properties.all, fromTable: TB_Person, where: KPerson.Properties.name.like("%\(name)%"))
        return persons
    }
}


extension KPersonListTableVC {
    /// 删除动作
    private func deleteAction(indexPath: IndexPath) {
        let cancleAction = UIAlertAction(title: "取消", style: .cancel)
        let confirmAction = UIAlertAction(title: "确定", style: .default) { (action) in
            
            guard let p = self.dataArray?[indexPath.row]  else {
                return
            }

            KDBManager.share.deleteFromDb(fromTable: TB_Person, where: p.id)
            SVProgressHUD.showSuccess(withStatus: "删除成功!")
            self.dataArray?.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let alert = UIAlertController(title: "", message: "是否删除?", preferredStyle: .alert)
        alert.addAction(cancleAction)
        alert.addAction(confirmAction)
        present(alert, animated: true, completion: nil)
    }
    
    /// 编辑动作
    private func editAction(indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if let editController = sb.instantiateViewController(withIdentifier: "KAddPersonVC") as? KAddPersonVC {
            editController.title = "编辑"
            editController.editType = .edit
            editController.person = dataArray?[indexPath.row]
            navigationController?.pushViewController(editController, animated: true)
        }else{
            print("Cant find VC!")
        }
    }
}


extension KPersonListTableVC {
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        if let person = dataArray?[indexPath.row] {
            cell.textLabel?.text = "\(person.name ?? "")-\(person.sex ?? "")-\(person.age ?? 0)"
        }
        return cell
    }
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "删除") { (action, indexPath) in
            self.deleteAction(indexPath: indexPath)
        }
        let editAction = UITableViewRowAction(style: .default, title: "编辑") { (action, indexPath) in
            self.editAction(indexPath: indexPath)
        }
        return [deleteAction, editAction]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension KPersonListTableVC: UISearchBarDelegate {
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dataArray = searchFor(searchText)
        tableView.reloadData()
    }
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
