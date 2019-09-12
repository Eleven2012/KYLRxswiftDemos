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

