//
//  KCompositionRoot.swift
//  kylJimuDemo
//
//  Created by yulu kong on 2019/9/18.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit

import CGFloatLiteral
import Kingfisher
import RxGesture
import RxOptional
import RxViewController
import SnapKit
import SwiftyColor
import SwiftyImage
import SwiftyUserDefaults
import Then
import URLNavigator
import NSObject_Rx
import ManualLayout
import GDPerformanceView_Swift
import Toaster
import Dollar
import WebKit
import SwiftDate

struct AppDependency {
    typealias OpenURLHandler = (_ url: URL, _ options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool
    
    let window: UIWindow
    let configureSDKs: () -> Void
    let configureAppearance: () -> Void
    let configureUserAgent: () -> Void
    let congigurePerformance: () -> Void
    let openURL: OpenURLHandler
}

let navigator = Navigator()
