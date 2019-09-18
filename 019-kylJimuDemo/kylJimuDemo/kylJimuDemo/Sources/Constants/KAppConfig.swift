//
//  KAppConfig.swift
//  kylJimuDemo
//
//  Created by yulu kong on 2019/9/18.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit

let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height
let kScreenRatio = kScreenHeight/736.f //以8ps为标准

let kToastBottomMaxSpace = 560.f * kScreenRatio
let kToastBottomCenterSpace = 420.f * kScreenRatio
let kBannerHeight = 120.f
let kNormalItemHeight = 180.f
let kAdItemHeight = 170.f
let kLiveItemHeight = 150.f
let kShadowImageHeight = 50.f
let kTipCellHeight = 30.f
let kCornerRadius = 6.f
let kCollectionItemPadding = 15.f
let kDislikeViewMaxWidth = 330.f
let kDislikeViewMinWidth = 180.f
let kDislikeCellHeight = 60.f
let kDislikeFooterHeight = 150.f
let kLivePartitionRefreshRotationTime: Double = 0.5
let kTimeoutIntervalForRequest: TimeInterval = 10
let kRecommendRecallDislikeMinute = 2

let isIphoneX = kScreenWidth == 375.f && kScreenHeight == 812.f

let bannerModuleId = 1
let regionModuleId = 2
let rcmdModuleId = 3
let hourRankModuleId = 4
let attentionModuleId = 13
