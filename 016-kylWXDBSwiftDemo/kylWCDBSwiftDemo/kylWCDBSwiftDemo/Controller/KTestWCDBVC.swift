//
//  KTestWCDBVC.swift
//  kylWCDBSwiftDemo
//
//  Created by yulu kong on 2019/9/10.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit
import WCDBSwift

class KTestWCDBVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
