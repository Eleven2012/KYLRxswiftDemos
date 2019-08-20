//
//  KLayout.swift
//  kyl_DSBrigeDemo
//
//  Created by yulu kong on 2019/8/20.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import Foundation
import UIKit

let isScrollEnabled = true.i5(false).ix(true).ipad(false)
let leftMargin = 10.i5(50).ix(100).ipad(1000)

let screenWidth = max(UIScreen.main.bounds.height, UIScreen.main.bounds.width)
let screenHeight = min(UIScreen.main.bounds.height, UIScreen.main.bounds.width)
let screenBounds = UIScreen.main.bounds

// MARK: - 判断 机型
let isiPhone5 = UIDevice.isiPhone5()
let isiPhone6 = UIDevice.isiPhone6()
let isiPhone6BigModel = UIDevice.isiPhone6BigMode()
let isiPhone6Plus = UIDevice.isiPhone6Plus()
let isiPhone6PlusBigMode = UIDevice.isiPhone6PlusBigMode()
let isiPhoneX = UIDevice.isiPhoneX()
let isIpad = UIDevice.isAiPad()

// MARK: - 系统类型
let kisiOS11 = UIDevice.isiOS11()
let kisiOS10 = UIDevice.isiOS10()
let kisiOS9 = UIDevice.isiOS9()
let kisiOS8 = UIDevice.isiOS8()


/// 设备横屏下,水平方向适配·
///
/// - Parameters:
///   - iPhone6Scale: iPhone6 水平方向@2x尺寸
///   - iPadScale: 分辨率比例为768*1024的iPad 水平方向@2x尺寸
/// - Returns: 适配后的尺寸
func layoutHorizontal(iPhone6 iPhone6Scale: Float, iPad iPadScale: Float) -> Float {
    
    let iphoneWidth = iPhone6Scale / 2
    let iPadWidth = iPadScale / 2
    
    var newWidth: Float = 0
    
    switch Device.type() {
    case .iPhone4:
        newWidth = iphoneWidth * (480.0 / 667.0)
    case .iPhone5:
        newWidth = iphoneWidth * (568.0 / 667.0)
    case .iPhone6:
        newWidth = iphoneWidth
    case .iPhone6p:
        newWidth = iphoneWidth * (736.0 / 667.0)
    case .iPhoneX:
        newWidth = iphoneWidth * ((812.0 - 78) / 667.0)
    case .iPhoneXR:
        newWidth = iphoneWidth * ((896.0 - 78) / 667.0)
    case .iPad_768_1024:
        newWidth = iPadWidth
    case .iPad_834_1112:
        newWidth = iPadWidth * (1112.0 / 1024.0)
    case .iPad_1024_1366:
        newWidth = iPadWidth * (1366.0 / 1024.0)
    }
    
    return newWidth
}


/// 设备横屏下,垂直方向适配
///
/// - Parameters:
///   - iPhone6Scale: iPhone6 垂直方向@2x尺寸
///   - iPadScale: 分辨率比例为768*1024的iPad 垂直方向@2x尺寸
/// - Returns: 适配后的尺寸
func layoutVertical(iPhone6 iPhone6Scale: Float, iPad iPadScale: Float) -> Float {
    
    let iphoneHeight = iPhone6Scale / 2
    let iPadHeight = iPadScale / 2
    
    var newHeight: Float = 0
    
    switch Device.type() {
    case .iPhone4:
        newHeight = iphoneHeight * (320.0 / 375.0)
    case .iPhone5:
        newHeight = iphoneHeight * (320.0 / 375.0)
    case .iPhone6:
        newHeight = iphoneHeight
    case .iPhone6p:
        newHeight = iphoneHeight * (414.0 / 375.0)
    case .iPhoneX:
        newHeight = iphoneHeight * (375.0 / 375.0)
    case .iPhoneXR:
        newHeight = iphoneHeight * (414.0 / 375.0)
    case .iPad_768_1024:
        newHeight = iPadHeight
    case .iPad_834_1112:
        newHeight = iPadHeight * (834.0 / 768.0)
    case .iPad_1024_1366:
        newHeight = iPadHeight * (1024.0 / 768.0)
    }
    
    return newHeight
}

/// 获取设备型号
enum Device {
    
    case iPhone4            /// 4/4s          320*480  @2x
    case iPhone5            /// 5/5C/5S/SE    320*568  @2x
    case iPhone6            /// 6/6S/7/8      375*667  @2x
    case iPhone6p           /// 6P/6SP/7P/8P  414*736  @3x
    case iPhoneX            /// X             375*812   @3x
    //    case iPhoneXS           /// XS            375*812   @3x (同X)
    case iPhoneXR           /// XR            414*896   @2x (放大模式下为 375*812)
    //    case iPhoneXSMAX        /// XSMAX         414*896   @3x (同XR)
    
    
    case iPad_768_1024      /// iPad(5th generation)/iPad Air/iPad Air2/iPad pro(9.7)  768*1024  @2x
    case iPad_834_1112      /// iPad pro(10.5)  834*1112   @2x
    case iPad_1024_1366     /// iPad pro(12.9)  1024*1366  @2x
    
    
    /// 判断具体设备
    ///
    /// - Returns: 具体设备名
    static func type() -> Device {
        
        switch screenWidth {
        case 480.0:
            return .iPhone4
        case 568.0:
            return .iPhone5
        case 667.0:
            return .iPhone6
        case 736.0:
            return .iPhone6p
        case 812.0:
            return .iPhoneX
        case 896.0:
            return .iPhoneXR
        case 1024.0:
            return .iPad_768_1024
        case 1112.0:
            return .iPad_834_1112
        case 1366.0:
            return .iPad_1024_1366
        default:
            return .iPad_768_1024
        }
    }
    
    /// 判断是否为iPad
    ///
    /// - Returns: true 是, false 否
    static func isIPad() -> Bool  {
        //        print("() = \(self.type())")
        return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad)
    }
    
    static func isIPhone5() -> Bool {
        return Device.type() == Device.iPhone5 ? true : false
    }
    
    static var safeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets ?? .zero
        }
        return .zero
    }
    
    static var safeScreenWidth: CGFloat {
        return UIScreen.main.bounds.width-safeAreaInsets.left-safeAreaInsets.right
    }
    
    static var safeScreenHeight: CGFloat {
        return UIScreen.main.bounds.height-safeAreaInsets.top-safeAreaInsets.bottom
    }
    
}


extension UIDevice {
    
    func Version()->String{
        
        let appVersion: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        return appVersion
    }
    
    
    @objc public class func isiPhoneX() -> Bool {
        if (UIScreen.main.currentMode?.size.equalTo(CGSize.init(width: 1125, height: 2436)))! {
            return true
        }
        return false
    }
    
    public class func isiPhone6PlusBigMode() -> Bool {
        if (UIScreen.main.currentMode?.size.equalTo(CGSize.init(width: 1125, height: 2001)))! {
            return true
        }
        return false
    }
    
    public class func isiPhone6Plus() -> Bool {
        if (UIScreen.main.currentMode?.size.equalTo(CGSize.init(width:1242, height: 2208)))! {
            return true
        }
        return false
    }
    
    public class func isiPhone6BigMode() -> Bool{
        if (UIScreen.main.currentMode?.size.equalTo(CGSize.init(width: 320, height: 568)))! {
            return true
        }
        return false
    }
    
    public class func isiPhone6() -> Bool {
        if (UIScreen.main.currentMode?.size.equalTo(CGSize.init(width:750, height: 1334)))! {
            return true
        }
        return false
    }
    
    public class func isiPhone5() -> Bool {
        if (UIScreen.main.currentMode?.size.equalTo(CGSize.init(width: 640, height: 1136)))! {
            return true
        }
        return false
    }
    
    public class func isiOS11() -> Bool {
        if #available(iOS 11.0, *) {
            return true
        } else {
            return false
        }
    }
    
    public class func isiOS10() -> Bool {
        if #available(iOS 10.0, *) {
            return true
        } else {
            return false
        }
    }
    
    public class func isiOS9() -> Bool {
        if #available(iOS 9.0, *) {
            return true
        } else {
            return false
        }
    }
    
    public class func isiOS8() -> Bool {
        if #available(iOS 8.0, *) {
            return true
        } else {
            return false
        }
    }
    
    public class func isAiPad() -> Bool {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
            return true
        }
        return false
    }
}


extension NSInteger {
    /// iphone 5 上的大小
    /// 🌶 《*注意运算顺序 -60.i5(-30) 等价于 -(60.i5(-30)) 结果为 -(-30) 或者 -60》
    ///
    /// - Parameter size: iphone 5 上的大小
    /// - Returns: isiPhone5 ? size : CGFloat(self)
    func i5(_ size: CGFloat) -> CGFloat {
        return isiPhone5 ? size : CGFloat(self)
    }
    
    /// iphone 6 放大模式上的大小
    /// 🌶 《*注意运算顺序 -60.i6BigModel(-30) 等价于 -(60.i6BigModel(-30)) 结果为 -(-30) 或者 -60》
    ///
    /// - Parameter size: iphone 6 放大模式 上的大小
    /// - Returns: isiPhone6BigModel ? size : CGFloat(self)
    func i6BigModel(_ size: CGFloat) -> CGFloat {
        return isiPhone6BigModel ? size : CGFloat(self)
    }
    
    /// iphone 6p 放大模式上的大小
    /// 🌶 《*注意运算顺序 -60.i6PBigModel(-30) 等价于 -(60.i6PBigModel(-30)) 结果为 -(-30) 或者 -60》
    ///
    /// - Parameter size: iphone 6p 放大模式 上的大小
    /// - Returns: isiPhone6PlusBigMode ? size  : CGFloat(self)
    func i6PBigModel(_ size: CGFloat) -> CGFloat {
        return isiPhone6PlusBigMode ? size : CGFloat(self)
    }
    
    /// iphone x 上的大小
    /// 🌶 《*注意运算顺序 -60.ix(-30) 等价于 -(60.ix(-30)) 结果为 -(-30) 或者 -60》
    ///
    /// - Parameter size: iphone x 上的大小
    /// - Returns: isiPhoneX ? size / 2.0 : CGFloat(self)
    func ix(_ size: CGFloat) -> CGFloat {
        return isiPhoneX ? size : CGFloat(self)
    }
    
    /// ipad
    /// 🌶 《*注意运算顺序 -60.ipad(-30) 等价于 -(60.ipad(-30)) 结果为 -(-30) 或者 -60》
    ///
    /// - Parameter size: ipad 上的大小
    /// - Returns: isIpad ? size : CGFloat(self)
    func ipad(_ size: CGFloat) -> CGFloat {
        return isIpad ? size : CGFloat(self)
    }
    
    /// 比例缩放 width
    ///
    /// - Parameter size: origin width
    /// - Returns: 比例缩放后的 width 没有除以2.0
    func scaleW() -> CGFloat {
        return (screenWidth / 375 * CGFloat(self))
    }
    /// 比例缩放 height result没有除以2.0
    ///
    /// - Parameter size: origin height
    /// - Returns: 比例缩放后的 height 没有除以2.0
    func scaleH() -> CGFloat {
        return (screenHeight / 667 * CGFloat(self))
    }
}


extension CGFloat {
    
    /// iphone 5 上的大小
    /// 🌶 《*注意运算顺序 -60.i5(-30) 等价于 -(60.i5(-30)) 结果为 -(-30) 或者 -60》
    ///
    /// - Parameter size: iphone 5 上的大小
    /// - Returns: isiPhone5 ? size : self
    func i5(_ size: CGFloat) -> CGFloat {
        return isiPhone5 ? size : self
    }
    
    /// iphone 6 放大模式上的大小
    /// 🌶 《*注意运算顺序 -60.i6BigModel(-30) 等价于 -(60.i6BigModel(-30)) 结果为 -(-30) 或者 -60》
    ///
    /// - Parameter size: iphone 6 放大模式 上的大小
    /// - Returns: isiPhone6BigModel ?  : self
    func i6BigModel(_ size: CGFloat) -> CGFloat {
        return isiPhone6BigModel ? size : self
    }
    
    /// iphone 6p 放大模式上的大小
    /// 🌶 《*注意运算顺序 -60.i6PBigModel(-30) 等价于 -(60.i6PBigModel(-30)) 结果为 -(-30) 或者 -60》
    ///
    /// - Parameter size: iphone 6p 放大模式 上的大小
    /// - Returns: isiPhone6PlusBigMode ? size : self
    func i6PBigModel(_ size: CGFloat) -> CGFloat {
        return isiPhone6PlusBigMode ? size : self
    }
    
    /// iphone x上的大小
    /// 🌶 《*注意运算顺序 -60.ix(-30) 等价于 -(60.ix(-30)) 结果为 -(-30) 或者 -60》
    ///
    /// - Parameter size: iphone x 上的大小
    /// - Returns: isiPhoneX ? size  : self
    func ix(_ size: CGFloat) -> CGFloat {
        return isiPhoneX ? size : self
    }
    
    /// ipad 上的大小
    /// 🌶 《*注意运算顺序 -60.ipad(-30) 等价于 -(60.ipad(-30)) 结果为 -(-30) 或者 -60》
    ///
    /// - Parameter size: ipad 上的大小
    /// - Returns: isIpad ? size : self
    func ipad(_ size: CGFloat) -> CGFloat {
        return isIpad ? size : self
    }
    
    
    /// 比例缩放 width
    ///
    /// - Parameter size: origin width
    /// - Returns: 比例缩放后的 width 没有除以2.0
    func scaleW() -> CGFloat {
        return (screenWidth / 375 * self)
    }
    /// 比例缩放 height
    ///
    /// - Parameter size: origin height
    /// - Returns: 比例缩放后的 height 没有除以2.0
    func scaleH() -> CGFloat {
        return (screenHeight / 667 * self)
    }
}


extension Bool {
    /// iphone 5 上的大小
    ///
    /// - Parameter size: iphone 5 上的大小
    /// - Returns: isiPhone5 ? size : self
    func i5(_ size: Bool) -> Bool {
        return isiPhone5 ? size : self
    }
    
    /// iphone 6 放大模式上的大小
    ///
    /// - Parameter size: iphone 6 放大模式 上的大小
    /// - Returns: isiPhone6BigModel ? size : self
    func i6BigModel(_ size: Bool) -> Bool {
        return isiPhone6BigModel ? size : self
    }
    
    /// iphone 6p 放大模式上的大小
    ///
    /// - Parameter size: iphone 6p 放大模式 上的大小
    /// - Returns: isiPhone6PlusBigMode ? size  : self
    func i6PBigModel(_ size: Bool) -> Bool {
        return isiPhone6PlusBigMode ? size : self
    }
    
    /// iphone x 上的大小
    ///
    /// - Parameter size: iphone x 上的大小
    /// - Returns: isiPhoneX ? size / 2.0 : self
    func ix(_ size: Bool) -> Bool {
        return isiPhoneX ? size : self
    }
    
    /// ipad
    ///
    /// - Parameter size: ipad 上的大小
    /// - Returns: isIpad ? size : self
    func ipad(_ size: Bool) -> Bool {
        return isIpad ? size : self
    }
}
