//
//  KYLMoyaTestViewController.swift
//  kylRxMemoryDemo
//
//  Created by yulu kong on 2019/8/28.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import RxDataSources
import Then
import SnapKit
import Moya
import Kingfisher
import MJRefresh

class KYLMoyaTestViewController: UIViewController {

    let viewModel = KYLMViewModel()

    let tableView = UITableView().then {
        $0.backgroundColor = UIColor.red
        $0.register(cellType: KYLMTableViewCell.self)
        $0.rowHeight = KYLMTableViewCell.cellHeigh()
    }
    let dataSource = RxTableViewSectionedReloadDataSource<KYLMSection>(configureCell: { ds, tv, ip, item in
        let cell = tv.dequeueReusableCell(for: ip) as KYLMTableViewCell
        cell.picView.kf.setImage(with: URL(string: item.url))
        cell.descLabel.text = "描述: \(item.desc)"
        cell.sourceLabel.text = "来源: \(item.source)"
        return cell
    })
    var vmOutput : KYLMViewModel.KYLMOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindView()
        
        // 加载数据
        tableView.mj_header.beginRefreshing()
    }

}

extension KYLMoyaTestViewController {
    fileprivate func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(view.snp.top).offset(20);
        }
    }
    
    fileprivate func bindView() {
        
        // 设置代理
        tableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
        
        
        let vmInput = KYLMViewModel.KYLMInput(category: .welfare)
        let vmOutput = viewModel.transform(input: vmInput)
        
        vmOutput.sections.asDriver().drive(tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        
        vmOutput.refreshStatus.asObservable().subscribe(onNext: {[weak self] status in
            switch status {
            case .beingHeaderRefresh:
                self?.tableView.mj_header.beginRefreshing()
            case .endHeaderRefresh:
                self?.tableView.mj_header.endRefreshing()
            case .beingFooterRefresh:
                self?.tableView.mj_footer.beginRefreshing()
            case .endFooterRefresh:
                self?.tableView.mj_footer.endRefreshing()
            case .noMoreData:
                self?.tableView.mj_footer.endRefreshingWithNoMoreData()
            default:
                break
            }
        }).disposed(by: rx.disposeBag)
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            vmOutput.requestCommond.onNext(true)
        })
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            vmOutput.requestCommond.onNext(false)
        })
    }
}

extension KYLMoyaTestViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
