//
//  KGlobalDefine.swift
//  kylRxSimpleDemo
//
//  Created by yulu kong on 2019/9/3.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit

let isIphoneX : Bool = kScreenH == 812.0 ? true : false
let kNavBarTotalH :CGFloat = isIphoneX ? 88 : 64
let kScreenW = UIScreen.main.bounds.width
let kScreenH = UIScreen.main.bounds.height
