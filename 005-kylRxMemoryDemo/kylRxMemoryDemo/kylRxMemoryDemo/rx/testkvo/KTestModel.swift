//
//  KTestModel.swift
//  kylRxMemoryDemo
//
//  Created by yulu kong on 2019/8/24.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import Foundation

class LGPerson: NSObject {
    @objc dynamic var name:String = "Cooci"
    @objc dynamic weak var student:LGStudent? = LGStudent(nickName: "KC")
    @objc dynamic var age : String = "18"
    //    @objc dynamic var age : Int = 18
    @objc dynamic var array: Array<String>?
    
    override init() {
    }
}

class LGStudent: NSObject {
    @objc dynamic var nickName:String = "KC"
    
    init(nickName: String) {
        self.nickName = nickName
    }
}


