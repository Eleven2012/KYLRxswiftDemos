//
//  KRxTestViewModel.swift
//  kylRxSimpleDemo
//
//  Created by yulu kong on 2019/9/3.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit

class KRxTestViewModel: NSObject {
    
    @objc dynamic var dataArray = [Any]()
    
    override init() {
        super.init()
        self.loadData()
    }
    /// 数据请求
    func loadData() {
        
        DispatchQueue.global().async {
            let array = [
                ["iconPath":"","name":"基础使用","className":"KRxTableViewEditTestVC","desc":"Rx简单序列使用"],
                ["iconPath":"","name":"高阶函数使用","className":"KRxHigherFunctionTestVC","desc":"Rx高阶函数使用"],
                ["iconPath":"","name":"Rx内存管理","className":"","desc":"讲解Rx使用中的循环引用问题"],
                ["iconPath":"","name":"RxCocoa UI使用","className":"","desc":"讲解RxUI使用"],
                ["iconPath":"","name":"Rx MVVM Moya","className":"","desc":"讲解Rxswift MVVM架构模式,网络请求实例"]
            ]
            
            for dict in array {
                if let model = KRxTestModel.deserialize(from: dict) {
                    self.dataArray.append(model)
                }
            }
        }
    }
}
