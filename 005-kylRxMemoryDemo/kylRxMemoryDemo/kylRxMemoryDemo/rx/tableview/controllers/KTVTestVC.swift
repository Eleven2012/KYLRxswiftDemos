//
//  KTVTestVC.swift
//  kylRxMemoryDemo
//
//  Created by yulu kong on 2019/8/24.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit
import RxSwift

//底部的安全距离
let bottomSafeAreaHeight =  UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0.0
//顶部的安全距离
let topSafeAreaHeight = CGFloat(bottomSafeAreaHeight == 0 ? 0 : 24)
//状态栏高度
let statusBarHeight = UIApplication.shared.statusBarFrame.height;
//导航栏高度
let navigationHeight = CGFloat(bottomSafeAreaHeight == 0 ? 64 : 88)
//tabbar高度
let tabBarHeight = CGFloat(bottomSafeAreaHeight + 49)
//屏幕宽度
let kScreenW = UIScreen.main.bounds.width
//屏幕高度
let kScreenH = UIScreen.main.bounds.height
//底部视图高度
let bottomViewH = CGFloat(124)
//底部按钮的大小
let buttonSize = CGFloat(64)
//底部按钮布局空隙
let buttonMargin = CGFloat(36)


class KTVTestVC: UIViewController {
    
    let resuseID = "resuseID_LGViewController"
    var modelItems: [KTVModel] = []
    var modelsSub: BehaviorSubject<[KTVModel]>?
    let disposeBag = DisposeBag()
    var detailVC:KTVDetailVC?
    
    lazy var tableView: UITableView = {
        let tabView = UITableView.init(frame: CGRect(x: 0, y: navigationHeight, width: kScreenW, height: kScreenH-navigationHeight-bottomViewH), style: .plain)
        tabView.delegate = self
        tabView.dataSource = self
        tabView.rowHeight = 50
        tabView.tableFooterView = UIView()
        tabView.register(KTVTableViewCell.classForCoder(), forCellReuseIdentifier: resuseID)
        return tabView
    }()
    
    lazy var deleteBtn: UIButton = {
        let button = UIButton(frame: CGRect(x: buttonMargin, y: kScreenH-bottomViewH+buttonMargin, width: buttonSize, height: buttonSize))
        button.setBackgroundImage(UIImage.init(named: "Delete"), for: .normal)
        return button
    }()
    
    lazy var saveBtn: UIButton = {
        let button = UIButton(frame: CGRect(x: kScreenW-buttonMargin-buttonSize, y: kScreenH-bottomViewH+buttonMargin, width: buttonSize, height: buttonSize))
        button.setBackgroundImage(UIImage.init(named: "Save"), for: .normal)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        modelsSub = BehaviorSubject(value: KTVCacheManager.manager.fetachKTVModelData())
        modelsSub?.subscribe(onNext: { [weak self](items) in
            self?.modelItems = items
            self?.tableView.reloadData()
            self?.deleteBtn.isEnabled = !items.isEmpty
            KTVCacheManager.manager.updataAllData(models: items)
            let num = items.filter({ (model) -> Bool in
                return !model.isFinished
            }).count
            self?.navigationItem.rightBarButtonItem?.isEnabled = num <= 6
            self?.title = num == 0 ? "RxSwiftDemo" : "还有 \(num) 条代办"
        }).disposed(by: disposeBag)
        
    }
    
    //MARK: - UI处理
    func setupUI(){
        self.view.backgroundColor = UIColor.lightGray
        /// 加载tableView
        self.view.addSubview(self.tableView)
        self.view.addSubview(deleteBtn)
        self.view.addSubview(saveBtn)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(didClickAddAction))
    }
    
    @objc func didClickAddAction(){
        pushToDetailVC(model: nil)
    }
    
    fileprivate func pushToDetailVC(model:KTVModel?){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        detailVC = (sb.instantiateViewController(withIdentifier: "KTVDetailVC") as! KTVDetailVC)
        
        if let model = model {
            detailVC?.model = model
        }
        // 订阅回调更新UI
        detailVC?.todoOB.subscribe(onNext: { [weak self](model) in
            self?.modelItems.append(model)
            // 刷新数据缓存
            self?.modelsSub?.onNext(self?.modelItems ?? [])
        }).disposed(by: disposeBag)
        
        self.navigationController?.pushViewController(detailVC!, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let naviController = segue.destination
        print(naviController)
    }
    
}

//MARK: - tableView的数据源和代理
extension KTVTestVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = KTVTableViewCell.init(style: .default, reuseIdentifier: resuseID)
        cell.upDataUIWithModle(model: modelItems[indexPath.row])
        return cell
    }
}

extension KTVTestVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // 点击选择就是删除
        // 处理数据
        modelItems.remove(at: indexPath.row)
        modelsSub?.onNext(modelItems)
        // 刷新数据缓存
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = modelItems[indexPath.row]
        pushToDetailVC(model: model)
        
    }
}

