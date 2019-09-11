//
//  KTestSQLiteVC.swift
//  kylSQLite3SwiftDemo
//
//  Created by yulu kong on 2019/9/11.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit

class KTestSQLiteVC: UIViewController {

    // 数据库声明
    var database: Database!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 与数据库建立连接
        database = Database()
        
        // 建立列表（有列表后不再建立）
        database.tableLampCreate()
        
        // 插入两条数据
        database.tableLampInsertItem(address: 51, name: "灯光1", colorValue: "#FFFFFF", lampType: 0)
        database.tableLampInsertItem(address: 52, name: "灯光2", colorValue: "#AAAAAA", lampType: 1)
        
        // 遍历列表（检查插入结果）
        database.queryTableLamp()
        
        // 根据条件查询
        database.readTableLampItem(address: 52)
        
        // 修改列表项
        database.tableLampUpdateItem(address: 51, newName: "客厅大灯")
        
        // 遍历列表（检查修改结果）
        database.queryTableLamp()
        
        // 删除列表项
        database.tableLampDeleteItem(address: 52)
        
        // 遍历列表（检查删除结果）
        database.queryTableLamp()
        
    }
   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
