//
//  KCTableViewCell.swift
//  kyl_DSBrigeDemo
//
//  Created by yulu kong on 2019/8/21.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


class KCTableViewCell: UITableViewCell {
    
    var button:UIButton!
    var disposeBag = DisposeBag()
    
    //初始化
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //添加按钮
        button = UIButton(frame:CGRect(x:100, y:5, width:200, height:30))
        button.setTitle("RxSwift点击按钮", for:.normal)
        button.backgroundColor = UIColor.orange
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.contentView.addSubview(button)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
