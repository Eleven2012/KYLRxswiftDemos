//
//  ViewController.swift
//  kylRealmSwiftDemo
//
//  Created by yulu kong on 2019/9/12.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension ViewController {
    private func testAdd() {
        do {
            
            let RESULT_DATA = "data"//数据包
            let responseData = Data(base64Encoded: "testFromJsonData")
            guard  let response = responseData else {
                return
            }
            let json = try JSON(data: response)
            let jsonArray = json[RESULT_DATA].arrayObject!
            let data = try! JSONSerialization.data(withJSONObject: jsonArray, options: JSONSerialization.WritingOptions.prettyPrinted)
            let cacheModel = TogetherRealmModel()
            cacheModel.data = data
            cacheModel.key = NSStringFromClass(TogetherRealmModel.self)
            KRealmManager.addCanUpdate(cacheModel)
            
        } catch {
            print(error)
        }
    }
    
    private func testDelete() {
        let realmModels: [ListRealmModel] = []
        KRealmManager.delete(realmModels)
    }
}


// MARK - 新增
extension ViewController {
    
    /// 保存一个Student
    private  func insertStudent(by student : Student) -> Void {
        KRealmManager.add(student)
    }
    
    /// 保存一些Student
    private func insertStudents(by students : [Student]) -> Void {
        KRealmManager.addListData(students)
    }
}

// MARK - 查询
extension ViewController {
    /// 获取 所保存的 Student
    public class func getStudents() -> [Student] {
        let results =  KRealmManager.selectByAll(Student.self)
        var students = [Student]()
        results.forEach { (item) in
            students.append(item)
        }
        return students
    }
    
    /// 获取 指定id (主键) 的 Student
    public class func getStudent(from id : Int) -> Student? {
        return KRealmManager.select(type: Student.self, by: "\(id)")
    }
    
    /// 获取 指定条件 的 Student
    public class func getStudentByTerm(_ term: String) -> [Student] {

        let results = KRealmManager.selectByNSPredicate(Student.self, predicate: NSPredicate(format: term))
        var students = [Student]()
        results.forEach { (item) in
            students.append(item)
        }
        return students
    }

    /// 获取 学号升降序 的 Student
    public class func getStudentByIdSorted(_ isAscending: Bool) -> [Student] {
        let results = KRealmManager.selectScoretByAll(Student.self, key: "id", isAscending: isAscending)
        var students = [Student]()
        results.forEach { (item) in
            students.append(item)
        }
        return students
    }
}

// MARK - 修改
extension ViewController {
    /// 更新单个 Student
    public class func updateStudent(student : Student) {
        KRealmManager.addCanUpdate(student)
    }
    
    /// 更新多个 Student
    public class func updateStudent(students : [Student]) {
        let defaultRealm = KRealmManager.sharedInstance
        try! defaultRealm.write {
            defaultRealm.add(students, update: .all)
        }
    }
    
    /// 更新多个 Student
    public class func updateStudentAge(age : Int) {
        let defaultRealm = KRealmManager.sharedInstance
        try! defaultRealm.write {
            let students = defaultRealm.objects(Student.self)
            students.setValue(age, forKey: "age")
        }
    }
}


// MARK - 删除
extension ViewController {
    /// 删除单个 Student
    public class func deleteStudent(student : Student) {
        let defaultRealm = KRealmManager.sharedInstance
        try! defaultRealm.write {
            defaultRealm.delete(student)
        }
    }
    
    /// 删除多个 Student
    public class func deleteStudent(students : [Student]) {
        KRealmManager.delete(students)
    }
}
