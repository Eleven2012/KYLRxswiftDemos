//
//  Sample.swift
//  kylWCDBSwiftDemo
//
//  Created by yulu kong on 2019/9/11.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import Foundation
import WCDBSwift

class Sample: TableCodable {
    var identifier: Int? = nil
    var description: String? = nil
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = Sample
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case identifier
        case description
        
        static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
                identifier: ColumnConstraintBinding(isPrimary: true),
            ]
        }
    }
}
