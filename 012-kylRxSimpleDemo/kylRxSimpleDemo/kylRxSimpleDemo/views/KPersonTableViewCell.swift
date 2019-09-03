//
//  KPersonTableViewCell.swift
//  kylRxSimpleDemo
//
//  Created by yulu kong on 2019/8/30.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
//import JXPhotoBrowser

class KPersonTableViewCell: UITableViewCell {

    let disposeBag = DisposeBag()
    /// 头像视图
    lazy var iconView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    // 用户昵称
    lazy var nameLabel: UILabel = {
        let nameLab = UILabel()
        nameLab.font = UIFont.systemFont(ofSize: 15)
        return nameLab
    }()
    
    // 所带课程
    lazy var classLabel: UILabel = {
        let classLab = UILabel()
        classLab.font = UIFont.systemFont(ofSize: 14)
        classLab.textColor = UIColor.gray
        return classLab
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
        self.setupPhotoBrowser()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// UI添加
    func setupUI() {
        
        self.contentView.addSubview(self.iconView)
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.classLabel)
        
        let iconViewSize = CGSize(width: 44, height: 44)
        let leftMargin   = 20;
        
        self.iconView.snp.makeConstraints { (make) in
            make.left.equalTo(leftMargin)
            make.centerY.equalToSuperview()
            make.size.equalTo(iconViewSize)
        }
        
        self.nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.iconView)
            make.left.equalTo(self.iconView.snp.right).offset(leftMargin/2)
        }
        
        self.classLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.iconView)
            make.left.equalTo(self.nameLabel)
            make.right.equalTo(-leftMargin)
        }
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setUIData(_ model:LGModel) {
        
        self.iconView.image = UIImage.init(named: model.name)
        self.nameLabel.text = model.name
        self.classLabel.text = model.className
        
        let iconViewSize = CGSize(width: 44, height: 44)
        self.iconView.lg_roundCorner(cornerRadii: iconViewSize.width/2)
    }
    
    func setUISectionData(_ model:LGSectionModel) {
        
        self.iconView.image = model.image
        self.nameLabel.text = model.name
        self.classLabel.text = model.gitHubID
        
        let iconViewSize = CGSize(width: 44, height: 44)
        self.iconView.lg_roundCorner(cornerRadii: iconViewSize.width/2)
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
