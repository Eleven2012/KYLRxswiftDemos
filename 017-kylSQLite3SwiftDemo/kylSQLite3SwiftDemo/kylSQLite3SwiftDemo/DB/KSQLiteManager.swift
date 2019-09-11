//
//  KSQLiteManager.swift
//  kylSQLite3SwiftDemo
//
//  Created by yulu kong on 2019/9/11.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit
import SQLite
import SwiftyJSON

let type_column = Expression<Int>("type")
let time_column = Expression<Int>("time")
let year_column = Expression<Int>("year")
let month_column = Expression<Int>("month")
let week_column = Expression<Int>("week")
let day_column = Expression<Int>("day")
let value_column = Expression<Double>("value")
let tag_column = Expression<String>("tag")
let detail_column = Expression<String>("detail")
let id_column = rowid

class SQLiteManager: NSObject {
    
    static let manager = SQLiteManager()
    private var db: Connection?
    private var table: Table?
    
    func getDB() -> Connection {
        
        if db == nil {
            
            let path = NSSearchPathForDirectoriesInDomains(
                .documentDirectory, .userDomainMask, true
                ).first!
            db = try! Connection("\(path)/db.sqlite3")
            db?.busyTimeout = 5.0
            
        }
        return db!
        
    }
    
    func getTable() -> Table {
        
        if table == nil {
            
            table = Table("records")
            
            try! getDB().run(
                table!.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (builder) in
                    
                    builder.column(type_column)
                    builder.column(time_column)
                    builder.column(year_column)
                    builder.column(month_column)
                    builder.column(week_column)
                    builder.column(day_column)
                    builder.column(value_column)
                    builder.column(tag_column)
                    builder.column(detail_column)
                    
                })
            )
            
        }
        return table!
        
    }
    
    //增
    func insert(item: JSON) {
        
        let insert = getTable().insert(type_column <- item["type"].intValue, time_column <- item["time"].intValue, value_column <- item["value"].doubleValue, tag_column <- item["tag"].stringValue , detail_column <- item["detail"].stringValue, year_column <- item["year"].intValue, month_column <- item["month"].intValue, week_column <- item["week"].intValue, day_column <- item["day"].intValue)
        if let rowId = try? getDB().run(insert) {
            print("插入成功：\(rowId)")
        } else {
            print("插入失败")
        }
        
    }
    
    //删单条
    func delete(id: Int64) {
        
        delete(filter: rowid == id)
        
    }
    
    //根据条件删除
    func delete(filter: Expression<Bool>? = nil) {
        
        var query = getTable()
        if let f = filter {
            query = query.filter(f)
        }
        if let count = try? getDB().run(query.delete()) {
            print("删除的条数为：\(count)")
        } else {
            print("删除失败")
        }
        
    }
    
    //改
    func update(id: Int64, item: JSON) {
        
        let update = getTable().filter(rowid == id)
        if let count = try? getDB().run(update.update(value_column <- item["value"].doubleValue, tag_column <- item["tag"].stringValue , detail_column <- item["detail"].stringValue)) {
            print("修改的结果为：\(count == 1)")
        } else {
            print("修改失败")
        }
        
    }
    
    //查
    func search(filter: Expression<Bool>? = nil, select: [Expressible] = [rowid, type_column, time_column, value_column, tag_column, detail_column], order: [Expressible] = [time_column.desc], limit: Int? = nil, offset: Int? = nil) -> [Row] {
        
        var query = getTable().select(select).order(order)
        if let f = filter {
            query = query.filter(f)
        }
        if let l = limit {
            if let o = offset{
                query = query.limit(l, offset: o)
            }else {
                query = query.limit(l)
            }
        }
        
        let result = try! getDB().prepare(query)
        return Array(result)
        
    }
    
}


