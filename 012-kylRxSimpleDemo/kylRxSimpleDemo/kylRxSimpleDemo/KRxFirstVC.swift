//
//  KRxFirstTableVC.swift
//  kylRxSimpleDemo
//
//  Created by yulu kong on 2019/8/30.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit

class KRxFirstVC: KBaseViewController {
    
    let viewModel = LGViewModel()
    
    lazy var tableView: UITableView = {
        let tabView = UITableView.init(frame: self.view.bounds, style: .plain)
        tabView.delegate = self
        tabView.dataSource = self
        tabView.tableFooterView = UIView()
        tabView.register(KPersonTableViewCell.classForCoder(), forCellReuseIdentifier: resuseID)
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

extension KRxFirstVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = KPersonTableViewCell.init(style: .default, reuseIdentifier: resuseID)
        guard let model = viewModel.dataArray[indexPath.row] as? LGModel else {
            return cell
        }
        cell.setUIData(model)
        return cell
    }
    
}

extension KRxFirstVC:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = viewModel.dataArray[indexPath.row] as? LGModel else {
            return
        }
        debugPrint("点击:\(model.name), desc:\(model.desc), class:\(model.className)")
//        guard  let cls = NSClassFromString(model.className) as? UIViewController.Type else {
//            debugPrint("点击的className获取不到UIViewController,\(String(describing: NSClassFromString(model.className)))")
//            return
//        }
//        let vc = cls.init()
//        self.navigationController?.pushViewController(vc, animated: true)
        
        switch model.className {
        case "RxTestHigherFunctionVC":
            navigationController?.pushViewController(RxTestHigherFunctionVC(), animated: true)
            
        case "KRxTableViewEditTestVC":
            navigationController?.pushViewController(KRxTableViewEditTestVC(), animated: true)
        case "LGSectionViewController":
            navigationController?.pushViewController(LGSectionViewController(), animated: true)
        case "KHigherFunSectionVC":
            navigationController?.pushViewController(KHigherFunSectionVC(), animated: true)
        default:
            debugPrint("不处理")
        }
    }
}

