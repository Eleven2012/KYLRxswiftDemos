//
//  Student.swift
//  kylRealmSwiftDemo
//
//  Created by yulu kong on 2019/9/16.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit
import RealmSwift

class Book: Object {
    @objc dynamic var name = ""
    @objc dynamic var author = ""
    
    /// LinkingObjects 反向表示该对象的拥有者
    let owners = LinkingObjects(fromType: Student.self, property: "books")
    
    convenience init(name : String,author : String) {
        self.init();
        self.name = name;
        self.author = author;
    }
}

class Student: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = 18
    @objc dynamic var weight = 156
    @objc dynamic var id = 0
    @objc dynamic var address = ""
    @objc dynamic var birthday : NSDate? = nil
    @objc dynamic var photo : NSData?  = nil
    @objc dynamic var tempID : String?  = nil
    @objc dynamic var tempID2 : String?  = nil
    @objc dynamic var groupName : String?  = nil
    
    //List 用来表示一对多的关系：一个 Student 中拥有多个 Book。
    let books = List<Book>()
    
    //重写 Object.primaryKey() 可以设置模型的主键。
    //声明主键之后，对象将被允许查询，更新速度更加高效，并且要求每个对象保持唯一性。
    //一旦带有主键的对象被添加到 Realm 之后，该对象的主键将不可修改。
    override static func primaryKey() -> String? {
        return "id"
    }
    
    //重写 Object.ignoredProperties() 可以防止 Realm 存储数据模型的某个属性
    override static func ignoredProperties() -> [String] {
        return ["tempID"]
    }
    
    //重写 Object.indexedProperties() 方法可以为数据模型中需要添加索引的属性建立索引，Realm 支持为字符串、整型、布尔值以及 Date 属性建立索引。
    override static func indexedProperties() -> [String] {
        return ["name"]
    }
}


extension Student {
    /// 头像赋值
    public func setPhotoWitName(_ imageName : String) -> Void {
        let image = UIImage(named: imageName);
        guard image == nil else {
            self.photo = (image!.pngData()! as NSData)
            return
        }
    }
    
    /// 获取头像
    public func getPhotoImage() -> UIImage? {
        return UIImage(data: self.photo! as Data);
    }
}
