//
//  KPerson.swift
//  kylWCDBSwiftDemo
//
//  Created by yulu kong on 2019/9/10.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit
import WCDBSwift

class KPerson: TableCodable {
    init(name: String, sex: String, age: Int) {
        self.name = name
        self.sex = sex
        self.age = age
    }
    
    convenience init() {
        self.init(name: "", sex: "", age: 0)
    }
    
    var name: String?
    var sex: String?
    var age: Int?
    var id: Int?
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = KPerson
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        
        case name
        case sex
        case age
        case id
        
        //Column constraints for primary key, unique, not null, default value and so on. It is optional.
        static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
                .id: ColumnConstraintBinding(isPrimary: true, isAutoIncrement: true),
            ]
        }
    }
    
    //Properties below are needed only the primary key is auto-incremental
    var isAutoIncrement: Bool = false
    var lastInsertedRowID: Int64 = 0
}

class abc: WCDBSwift.TableCodable {
    //Your own properties
    let variable1: Int = 0
    var variable2: String? // Optional if it would be nil in some WCDB selection
    var variable3: Double? // Optional if it would be nil in some WCDB selection
    let unbound: Date? = nil
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = abc
        
        //List the properties which should be bound to table
        case variable1 = "custom_name"
        case variable2
        case variable3
        
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        
        //Column constraints for primary key, unique, not null, default value and so on. It is optional.
        //static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
        //    return [
        //        .variable: ColumnConstraintBinding(isPrimary: true, isAutoIncrement: true),
        //        .variable2: ColumnConstraintBinding(isUnique: true)
        //    ]
        //}
        
        //Index bindings. It is optional.
        //static var indexBindings: [IndexBinding.Subfix: IndexBinding]? {
        //    return [
        //        "_index": IndexBinding(indexesBy: CodingKeys.variable2)
        //    ]
        //}
        
        //Table constraints for multi-primary, multi-unique and so on. It is optional.
        //static var tableConstraintBindings: [TableConstraintBinding.Name: TableConstraintBinding]? {
        //    return [
        //        "MultiPrimaryConstraint": MultiPrimaryBinding(indexesBy: variable2.asIndex(orderBy: .descending), variable3.primaryKeyPart2)
        //    ]
        //}
        
        //Virtual table binding for FTS and so on. It is optional.
        //static var virtualTableBinding: VirtualTableBinding? {
        //    return VirtualTableBinding(with: .fts3, and: ModuleArgument(with: .WCDB))
        //}
    }
    
    //Properties below are needed only the primary key is auto-incremental
    var isAutoIncrement: Bool = true
    var lastInsertedRowID: Int64 = 0
}
