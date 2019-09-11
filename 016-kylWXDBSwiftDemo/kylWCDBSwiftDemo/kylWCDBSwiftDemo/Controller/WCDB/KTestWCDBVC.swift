//
//  KTestWCDBVC.swift
//  kylWCDBSwiftDemo
//
//  Created by yulu kong on 2019/9/10.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit
import WCDBSwift

let TB_Sample = "sampleTable"

class KTestWCDBVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private lazy var db : Database? = {
        //1.创建数据库
        let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/wcdb.db"
        let database = Database(withPath: docPath + "/wcdb.db")
        return database
    }()
}

// MARK - 建表
extension KTestWCDBVC {
    private func testCreateTable() {
        guard let db = db else {
            return
        }
        do {
            //创建数据库表
            try db.create(table: TB_Sample, of: Sample.self)
            
        } catch {
            print(error)
        }
    }
}



// MARK - 插入操作
extension KTestWCDBVC {
    private func testInsert() {
        guard let db = db else {
            return
        }
        do {
            //插入数据库
            let object = Sample()
            object.identifier = 1
            object.description = "insert"
            try db.insert(objects: object, intoTable: TB_Sample) // 插入成功
            
            try db.insert(objects: object, intoTable: TB_Sample) // 插入失败，因为主键 identifier = 1 已经存在
            
            object.description = "insertOrReplace"
            try db.insertOrReplace(objects: object, intoTable: TB_Sample) // 插入成功，且 description 的内容会被替换为 "insertOrReplace"
            
        } catch {
            print(error)
        }
    }
}

// MARK - 更新操作
extension KTestWCDBVC {
    private func testUpdate2() {
        guard let db = db else {
            return
        }
        do {
            //更新数据
            let object = Sample()
            object.description = "update"
            
            // 将 sampleTable 中前三行的 description 字段更新为 "update"
            try db.update(table: TB_Sample,
                          on: Sample.Properties.description,
                          with: object,
                          limit: 3)
            
            // 将 sampleTable 中所有 identifier 大于 1 且 description 字段不为空 的行的 description 字段更新为 "update"
//            try db.update(table: TB_Sample,
//                          on: Sample.Properties.description,
//                          with: object,
//                          where: Sample.Properites.identifier > 1 && Sample.Properties.description.isNotNull()
//                          )
            
            
//            let row: [ColumnCodableBase] = ["update"]
            
            // 将 sampleTable 中所有 identifier 大于 1 且 description 字段不为空 的行的 description 字段更新为 "update"
//            try db.update(table: TB_Sample,
//                on: Sample.Properties.description,
//                with: row,
//                where: Sample.Properites.identifier > 1 && Sample.Properties.description.isNotNull())
            
            // 将 sampleTable 中前三行的 description 字段更新为 "update"
//            try db.update(table: "sampleTable",
//                on: Sample.Properties.description,
//                with: row,
//                limit: 3)
            
            
        } catch {
            print(error)
        }
    }
    
    private func testUpdate() {
        guard let db = db else {
            return
        }
        do {
            //更新数据
            let object = Sample()
            object.description = "update"
            
            // 将 sampleTable 中前三行的 description 字段更新为 "update"
            try db.update(table: TB_Sample,
                          on: Sample.Properties.description,
                          with: object,
                          limit: 3)
            
        } catch {
            print(error)
        }
    }
}

// MARK - 删除操作
extension KTestWCDBVC {
    private func testDelete2() {
        guard let db = db else {
            return
        }
        do {
            //删除操作
            // 删除 sampleTable 中所有 identifier 大于 1 的行的数据
            try db.delete(fromTable: TB_Sample,
                                where: Sample.Properties.identifier > 1)
            
            // 删除 sampleTable 中 identifier 降序排列后的前 2 行数据
//            try db.delete(fromTable: TB_Sample,
//                                orderBy: Sample.Properties.identifier.asOrder(by: .descending),
//                                limit: 2)
            
            // 删除 sampleTable 中 description 非空的数据，按 identifier 降序排列后的前 3 行的后 2 行数据
//            try db.delete(fromTable: TB_Sample,
//                                where: Sample.Properties.description.isNotNull(),
//                                orderBy: Sample.Properties.identifier.asOrder(by: .descending),
//                                limit: 2,
//                                offset: 3)
            
            // 删除 sampleTable 中的所有数据
            try db.delete(fromTable: TB_Sample)
            
        } catch {
            print(error)
        }
    }
    
    private func testDelete() {
        guard let db = db else {
            return
        }
        do {
            //删除操作
            // 删除 sampleTable 中所有 identifier 大于 1 的行的数据
            try db.delete(fromTable: TB_Sample,
                          where: Sample.Properties.identifier > 1)
            
            // 删除 sampleTable 中的所有数据
            try db.delete(fromTable: TB_Sample)
            
        } catch {
            print(error)
        }
    }
}

// MARK - 查询操作
extension KTestWCDBVC {
    private func testQuery() {
        guard let db = db else {
            return
        }
        do {
            //查询操作
            // 返回 sampleTable 中的所有数据
            let allObjects: [Sample] = try db.getObjects(fromTable: TB_Sample)
            
            print(allObjects)
            
            // 返回 sampleTable 中 identifier 小于 5 或 大于 10 的行的数据
            let objects: [Sample] = try db.getObjects(fromTable: TB_Sample,
                                                            where: Sample.Properties.identifier < 5 || Sample.Properties.identifier > 10)
            print(objects)
            
            // 返回 sampleTable 中 identifier 最大的行的数据
//            let object: Sample? = try db.getObject(fromTable: TB_Sample,
//                                                         orderBy: Sample.Properties.identifier.asOrder(by: .descending))
            
            // 获取所有内容
            let allRows = try db.getRows(fromTable: TB_Sample)
            print(allRows[row: 2, column: 0].int32Value) // 输出 3
            
            // 获取第二行
            let secondRow = try db.getRow(fromTable: TB_Sample, offset: 1)
            print(secondRow[0].int32Value) // 输出 2
            
            // 获取 description 列
            let descriptionColumn = try db.getColumn(on: Sample.Properties.description, fromTable: TB_Sample)
            print(descriptionColumn) // 输出 "sample1", "sample1", "sample1", "sample2", "sample2"
            
            // 获取不重复的 description 列的值
            let distinctDescriptionColumn = try db.getDistinctColumn(on: Sample.Properties.description, fromTable: TB_Sample)
            print(distinctDescriptionColumn) // 输出 "sample1", "sample2"
            
            // 获取第二行 description 列的值
            let value = try db.getValue(on: Sample.Properties.description, fromTable: TB_Sample, offset: 1)
            print(value.stringValue) // 输出 "sample1"
            
            // 获取 identifier 的最大值
            let maxIdentifier = try db.getValue(on: Sample.Properties.identifier.max(), fromTable: TB_Sample)
            print(maxIdentifier.stringValue)
            
            // 获取不重复的 description 的值
            let distinctDescription = try db.getDistinctValue(on: Sample.Properties.description, fromTable: TB_Sample)
            print(distinctDescription.stringValue) // 输出 "sample1"
            
        } catch {
            print(error)
        }
    }
}


extension KTestWCDBVC {
    /// 基本的数据库操作
    func baseOperation() {
        
        do {
            let p1 = KPerson(name: "walden", sex: "male", age: 21)
            let p2 = KPerson(name: "healer", sex: "female", age: 20)
            
            let tableName = "PersonTable"
            
            //1.创建数据库
            let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/wcdb.db"
            let db = Database(withPath: docPath + "/wcdb.db")
            
            //2.创建数据库表
            try db.create(table: tableName, of: KPerson.self)
            
            //3.插入数据
            try db.insert(objects: p1, p2, intoTable: tableName)
            
            //4.查找数据
            let objects: [KPerson]? = try? db.getObjects(fromTable: tableName)
            
            //5.更新操作
            let obj = objects!.first!
            obj.age = 30
            //            try db.update(table: tableName, on: Person.Properties, with: obj)
            
            let exp = KPerson.Properties.id > 1
            try db.delete(fromTable: "PersonTable", where: exp)
            
            //6.删除操作
            try db.delete(fromTable: tableName)
        } catch {
            print(error)
        }
        
    }
}
