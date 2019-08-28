//
//  KYLMModel.swift
//  kylRxMemoryDemo
//
//  Created by yulu kong on 2019/8/28.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import Foundation
import ObjectMapper
import RxDataSources

struct KYLMModel: Mappable {
    var _id         = ""
    var createdAt   = ""
    var desc        = ""
    var publishedAt = ""
    var source      = ""
    var type        = ""
    var url         = ""
    var used        = ""
    var who         = ""
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        _id         <- map["_id"]
        createdAt   <- map["createdAt"]
        desc        <- map["desc"]
        publishedAt <- map["publishedAt"]
        source      <- map["source"]
        type        <- map["type"]
        url         <- map["url"]
        used        <- map["used"]
        who         <- map["who"]
    }
}


/* ============================= SectionModel =============================== */

struct KYLMSection {
    
    var items: [Item]
}

extension KYLMSection: SectionModelType {
    
    typealias Item = KYLMModel
    
    init(original: KYLMSection, items: [KYLMSection.Item]) {
        self = original
        self.items = items
    }
}


