//
//  KTVModel.swift
//  kylRxMemoryDemo
//
//  Created by yulu kong on 2019/8/24.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit
import WCDBSwift

class KTVModel: TableCodable{
    var tittle: String = ""
    var isFinished: Bool = false
    
    init(tittle: String, isFinished: Bool) {
        self.tittle = tittle
        self.isFinished = isFinished
    }
    
    func toggleFinished() {
        isFinished = !isFinished
    }
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = KTVModel
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case tittle
        case isFinished
    }
}
