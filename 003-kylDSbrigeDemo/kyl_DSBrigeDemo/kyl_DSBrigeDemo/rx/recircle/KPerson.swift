//
//  KPerson.swift
//  kyl_DSBrigeDemo
//
//  Created by yulu kong on 2019/8/21.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import Foundation

class KPerson: NSObject {
    
    @objc dynamic var name:String = "kongyulu"
    
    override init() {
        super.init()
    }
    
    deinit {
        print("\(self)销毁释放")
    }
}
