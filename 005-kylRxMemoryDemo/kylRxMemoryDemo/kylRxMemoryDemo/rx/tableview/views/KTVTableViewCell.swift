//
//  KTVTableViewCell.swift
//  kylRxMemoryDemo
//
//  Created by yulu kong on 2019/8/24.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit
import SnapKit

class KTVTableViewCell: UITableViewCell {
    
    // 状态文本
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "✅"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    // 标题文本
    lazy var tittleLabel: UILabel = {
        let label = UILabel()
        label.text = "待办事项"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    
    /// UI添加
    func setupUI() {
        
        self.contentView.addSubview(statusLabel)
        self.contentView.addSubview(tittleLabel)
        
        let leftMargin = 20;
        
        self.statusLabel.snp.makeConstraints { (make) in
            make.left.equalTo(leftMargin)
            make.centerY.equalToSuperview()
        }
        self.tittleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.statusLabel.snp.right).offset(leftMargin/2)
            make.centerY.equalToSuperview()
        }
    }
    
    func upDataUIWithModle(model:KTVModel) {
        self.tittleLabel.text = model.tittle
        if model.isFinished {
            self.statusLabel.text = "✅"
        }else {
            self.statusLabel.text = ""
        }
    }
}
