//
//  KRxFuntionItemCell.swift
//  kylRxSimpleDemo
//
//  Created by yulu kong on 2019/9/3.
//  Copyright © 2019 yulu kong. All rights reserved.
//


import UIKit
import SnapKit
import RxSwift


class KRxFuntionItemCell: UITableViewCell {
    
    let disposeBag = DisposeBag()
    /// 头像视图
    lazy var iconView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    // 模块名称
    lazy var nameLabel: UILabel = {
        let nameLab = UILabel()
        nameLab.font = UIFont.systemFont(ofSize: 15)
        return nameLab
    }()
    
    // 模块描述
    lazy var descLabel: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.textColor = UIColor.gray
        return lab
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupPhotoBrowser()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// UI添加
    func setupUI() {
        
        contentView.addSubview(iconView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descLabel)
        
        let iconViewSize = CGSize(width: 44, height: 44)
        let leftMargin   = 20;
        
        iconView.snp.makeConstraints { (make) in
            make.left.equalTo(leftMargin)
            make.centerY.equalToSuperview()
            make.size.equalTo(iconViewSize)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconView)
            make.left.equalTo(iconView.snp.right).offset(leftMargin/2)
        }
        
        descLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(iconView)
            make.left.equalTo(nameLabel)
            make.right.equalTo(-leftMargin)
        }
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setUIData(_ model:KRxTestModel) {
        
        iconView.image = UIImage.init(named: model.name)
        nameLabel.text = model.name
        descLabel.text = model.desc
        
        let iconViewSize = CGSize(width: 44, height: 44)
        iconView.lg_roundCorner(cornerRadii: iconViewSize.width/2)
    }
    
    func setUISectionData(_ model:KRxTestSectionModel) {
        
        iconView.image = model.image
        nameLabel.text = model.name
        descLabel.text = model.gitHubID
        
        let iconViewSize = CGSize(width: 44, height: 44)
        iconView.lg_roundCorner(cornerRadii: iconViewSize.width/2)
    }
    
    func setupPhotoBrowser() {
        // 数据源
        //        let imageDataSource = JXLocalDataSource(numberOfItems: {
        //            // 共有多少项
        //            return 1
        //        }, localImage: { index -> UIImage? in
        //            // 每一项的图片对象
        //            if let image = UIImage(named: self.classLabel.text!) {
        //                return image
        //            }
        //            return UIImage(named: self.nameLabel.text!)
        //        })
        //        /// 给图片添加手势
        //        let tapGesture = UITapGestureRecognizer()
        //        self.iconView.addGestureRecognizer(tapGesture)
        //        tapGesture.rx.event.subscribe({ (event) in
        //            //JXPhotoBrowser(dataSource: imageDataSource).show(pageIndex: 0)
        //        }).disposed(by: self.disposeBag)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
