//
//  KMusicModel.swift
//  kylRxSimpleDemo
//
//  Created by yulu kong on 2019/9/3.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit

//歌曲结构体
struct Music {
    let name: String //歌名
    let singer: String //演唱者
    
    init(name: String, singer: String) {
        self.name = name
        self.singer = singer
    }
}

//实现 CustomStringConvertible 协议，方便输出调试
extension Music: CustomStringConvertible {
    var description: String {
        return "name：\(name) singer：\(singer)"
    }
}
