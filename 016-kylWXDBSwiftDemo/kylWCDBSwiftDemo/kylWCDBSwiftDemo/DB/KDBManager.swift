//
//  KDBManager.swift
//  kylWCDBSwiftDemo
//
//  Created by yulu kong on 2019/9/10.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import Foundation
import WCDBSwift

struct KDBPath {
    
    let dbPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                     .userDomainMask,
                                                     true).last! + "/KYL/KDB.db"
}


class KDBManager: NSObject {
    
    static let share = KDBManager()
    
    let dataBasePath = URL(fileURLWithPath: KDBPath().dbPath)
    var dataBase: Database?
    private override init() {
        super.init()
        dataBase = createDb()
    }
    ///创建db
    private func createDb() -> Database {
        debugPrint("数据库路径==\(dataBasePath.absoluteString)")
        return Database(withFileURL: dataBasePath)
    }
    ///创建表
    func createTable<T: TableDecodable>(table: String, of ttype:T.Type) -> Void {
        do {
            try dataBase?.create(table: table, of:ttype)
        } catch let error {
            debugPrint("create table error \(error.localizedDescription)")
        }
    }
    ///插入
    func insertToDb<T: TableEncodable>(objects: [T] ,intoTable table: String) -> Void {
        do {
            try dataBase?.insert(objects: objects, intoTable: table)
        } catch let error {
            debugPrint(" insert obj error \(error.localizedDescription)")
        }
    }
    
    ///修改
    func updateToDb<T: TableEncodable>(table: String, on propertys:[PropertyConvertible],with object:T,where condition: Condition? = nil) -> Void{
        do {
            try dataBase?.update(table: table, on: propertys, with: object,where: condition)
        } catch let error {
            debugPrint(" update obj error \(error.localizedDescription)")
        }
    }
    
    ///删除
    func deleteFromDb(fromTable: String, where condition: Condition? = nil) -> Void {
        do {
            try dataBase?.delete(fromTable: fromTable, where:condition)
        } catch let error {
            debugPrint("delete error \(error.localizedDescription)")
        }
    }
    
    ///查询
    func qureyFromDb<T: TableDecodable>(fromTable: String, cls cName: T.Type, where condition: Condition? = nil, orderBy orderList:[OrderBy]? = nil) -> [T]? {
        do {
            let allObjects: [T] = try (dataBase?.getObjects(fromTable: fromTable, where:condition, orderBy:orderList))!
            debugPrint("\(allObjects)");
            return allObjects
        } catch let error {
            debugPrint("no data find \(error.localizedDescription)")
        }
        return nil
    }
    
    ///删除数据表
    func dropTable(table: String) -> Void {
        do {
            try dataBase?.drop(table: table)
        } catch let error {
            debugPrint("drop table error \(error)")
        }
    }
    
    /// 删除所有与该数据库相关的文件
    func removeDbFile() -> Void {
        do {
            try dataBase?.close(onClosed: {
                try dataBase?.removeFiles()
            })
        } catch let error {
            debugPrint("not close db \(error)")
        }
    }
}


extension KDBManager {
    // insert 和 insertOrReplace 函数只有函数名不同，其他参数都一样。
    func insert<T: TableEncodable>(
        objects: [T], // 需要插入的对象。WCDB Swift 同时实现了可变参数的版本，因此可以传入一个数组，也可以传入一个或多个对象。
        on propertyConvertibleList: [PropertyConvertible]? = nil, // 需要插入的字段
        intoTable table: String // 表名
        ) {
        do {
            try dataBase?.insert(objects: objects, on: propertyConvertibleList, intoTable: table)
        } catch let error {
            debugPrint(" insert obj error \(error.localizedDescription)")
        }
    }
    
    //更新
    func update<T: TableEncodable>(
        table: String,
        on propertyConvertibleList: [PropertyConvertible],
        with object: T,
        where condition: Condition? = nil,
        orderBy orderList: [OrderBy]? = nil,
        limit: Limit? = nil,
        offset: Offset? = nil) {
        do {
            try dataBase?.update(table: table, on: propertyConvertibleList, with: object, where: condition, orderBy: orderList, limit: limit, offset: offset)
        } catch let error {
            debugPrint(" update obj error \(error.localizedDescription)")
        }
    }
    
    ///删除
    func delete(fromTable table: String, // 表名
        where condition: Condition? = nil, // 符合删除的条件
        orderBy orderList: [OrderBy]? = nil, // 排序的方式
        limit: Limit? = nil, // 删除的个数
        offset: Offset? = nil // 从第几个开始删除
        ) {
        do {
            try dataBase?.delete(fromTable: table, where: condition, orderBy: orderList, limit: limit, offset: offset)
        } catch let error {
            debugPrint("delete error \(error.localizedDescription)")
        }
    }
    
    //查询
    
    func getObjects<T: TableDecodable>(
        on propertyConvertibleList: [PropertyConvertible],
        fromTable table: String,
        where condition: Condition? = nil,
        orderBy orderList: [OrderBy]? = nil,
        limit: Limit? = nil,
        offset: Offset? = nil) -> [T]? {
        var list:[T]?
        do {
            try list = dataBase?.getObjects(on: propertyConvertibleList, fromTable: table, where: condition, orderBy: orderList, limit: limit, offset: offset)
        } catch let error {
            debugPrint("getObjects error \(error.localizedDescription)")
        }
        return list
    }
}
