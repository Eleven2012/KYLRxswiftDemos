//
//  ViewController.swift
//  kylWCDBSwiftDemo
//
//  Created by yulu kong on 2019/9/10.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit

let  TB_Person = "tb_kperson"


class ViewController: UIViewController {
    
    private let tableName = TB_Person

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        debugPrint("1--创建数据库表 \(tableName)")
        testCreateTable()
        
        // 创建数据
        //insertTestData()
        
        let list = query(fromTable: tableName)
        debugPrint("-----查询到数据：\(String(describing: list))")
        
        list?.forEach({ (person) in
            debugPrint("---age:\(String(describing: person.age)), name=\(String(describing: person.name)), id=\(String(describing: person.id))")
        })
        
        //更新数据
        
    }


}

// MARK - DB基础操作
extension ViewController {
    private func testCreateTable() {
        //2.创建数据库表
        KDBManager.share.createTable(table: tableName, of: KPerson.self)
    }
    
    // 插入测试数据
    private func insertTestData() {
        let p1 = KPerson(name: "walden", sex: "male", age: 21)
        let p2 = KPerson(name: "healer", sex: "female", age: 20)
        KDBManager.share.insertToDb(objects: [p1,p2], intoTable: tableName)
    }
    
     //4.查找数据
    private func query(fromTable:String) -> [KPerson]? {
        return KDBManager.share.qureyFromDb(fromTable: fromTable, cls: KPerson.self)
    }
    
    //更新数据
    private func testUpdateData() {
        guard let obj = query(fromTable: tableName)?.first else {
            return
        }
        obj.age = 30
    }
    
    // 删除数据
    private func testDeleteData() {
        
        //按条件删除某些数据
        KDBManager.share.deleteFromDb(fromTable: tableName, where: KPerson.Properties.age )
        
        //删除表中所有数据
        //KDBManager.share.deleteFromDb(fromTable: tableName)
    }
}
