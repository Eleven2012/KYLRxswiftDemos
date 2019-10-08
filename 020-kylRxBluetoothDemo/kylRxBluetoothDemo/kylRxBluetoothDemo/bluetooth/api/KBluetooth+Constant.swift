//
//  KBluetooth+Constant.swift
//  kylRxBluetoothDemo
//
//  Created by yulu kong on 2019/9/19.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import Foundation



// MARK - 配对信息
struct KPeri {
     var normal:[UInt]?
     var abnormal:[UInt]?
     var diffVersion:[UInt]?
     var version:String? //版本不一致的时候 取最小ID的版本号
}

// MARK - 电量信息
struct KPower {
     var voltage:Float?    //电压值
     var percent:Float?    //电压百分比
     var charging:Bool?    //是否充电
     var complete:Bool?    //充电是否完成
     var isDryBattery:Bool? //是否干电池 大于12.8v
}

// MARK - 机器人信息
struct KRobot {
     var version:String?        //版本号
     var power:KPower?          //电量信息
     var servo:KPeri?           //舵机信息
     var infrared:KPeri?        //红外信息
     var motor:KPeri?           //马达信息
     var gyro:KPeri?            //陀螺仪信息
     var touch:KPeri?           //触碰信息
     var led:KPeri?             //LED灯光信息
     var horn:KPeri?            //喇叭信息
     var color:KPeri?           //颜色传感器信息
     var ultrasound:KPeri?      //超声信息
     var rgbLight:KPeri?        //独角兽角灯信息
}

struct KBleConfig {
    
    static let serviceUUID   = "49535343-FE7D-4AE5-8FA9-9FAFD205E455"
    static let readCharUUID  = "49535343-1E4D-4BD9-BA61-23C647249616"
    static let writeCharUUID = "49535343-8841-43F4-A8D4-ECBE34729BB3"
    static let AIR_PATCH_CHAR = "49535343-ACA3-481C-91EC-D85E28A60318"
    
    static let cmdIndex = 3 //命令索引
    static let lenIndex = 2 //长度索引
    static let rereadMasterboradMaxCount = 2   //失败重新读取信息最大次数
    static let heartBeatMaxCount          = 4   //心跳最大未回次数
    static let aliveTimeout = 3.0               //心跳包间隔时间 s
    static let requestPowerTimeout = 30.0              //请求电量信息间隔时间 s
    static let requestMasterboardTimeout = 1.0         //重复读取主板信息时间间隔 s
    static let requestJimuCommandTimeout = 1.0        //判断是否是积木主控命令超时时间
    static let requestNormalCommandTimeout = 1.0      //普通命令超时时间
    static let upgradeCommandTimeout = 3.0     //升级命令超时时间
    static let masterboard8CommandTimeout = 5.0 //08命令超时时间
    static let oldMasterboardFinishUpgradeWaitTime:Int = 50 //旧主控升级完成等待超时时间
    static let power:Float = 7.4        //电压
    
    //需要升级的器件
    static let needUpgradeParts:[KRobotPartType] = [.masterboard,.servo,.infrared,.ultrasound,.touch,.gyro,.led,.horn]
    //需要开启传输功能的器件
    static let needTransmissionParts:[KRobotPartType] = [.rgbLight,.horn,.led,.infrared,.ultrasound,.touch,.gyro,.color]
    //积木用到的器件(注意顺序)
    static let jimuParts:[KRobotPartType] = [.rgbLight,.horn,.led,.infrared,.ultrasound,.touch,.gyro,.color,.servo,.motor]
    
}


// MARK - 机器人零件类型
public enum KRobotPartType:UInt8 {
    case servo      = 0  //舵机
    case infrared   = 1  //红外
    case touch      = 2  //触碰
    case gyro       = 3  //陀螺仪
    case led        = 4  //灯光
    case gravity    = 5  //重力
    case ultrasound = 6  //超声
    case nixieTube  = 7  //数码管
    case horn       = 8  //喇叭
    case color      = 9  //颜色
    case motor      = 10 //马达
    case sensirion  = 11 //温湿度
    case light      = 12 //光感
    case sound      = 13 //声音
    case rgbLight   = 14 //独角兽角灯
    
    case masterboard = 255 //主控
    
    var value:String{
        switch self {
        case .infrared:
            return "Infrared"
        case .touch:
            return "Touch"
        case .led:
            return "Light"
        case .rgbLight:
            return "RgbLight"
        case .color:
            return "Color"
        case .horn:
            return "Speaker"
        case .ultrasound:
            return "Ultrasonic"
        case .gyro:
            return "Gyro"
        case .light:
            return "EnLight"
        case .gravity:
            return "Gravity"
        case .nixieTube:
            return "DigitalTube"
        case .sound:
            return "Sound"
        case .sensirion:
            return "Temperature"
        default:
            return ""
        }
    }
    
    var localizedString:String{
        switch self {
        case .infrared:
            return "Infrared_sensor".KLocalizedString()
        case .touch:
            return "Touch_sensor".KLocalizedString()
        case .led:
            return "LED_light".KLocalizedString()
        case .rgbLight:
            return "UnicornBot_Light".KLocalizedString()
        case .color:
            return "Color_Sensor".KLocalizedString()
        case .horn:
            return "Bluetooth_speaker".KLocalizedString()
        case .ultrasound:
            return "Ultrasonic".KLocalizedString()
        case .gyro:
            return "gyro".KLocalizedString()
        case .light:
            return "光感".KLocalizedString()
        case .gravity:
            return "重力".KLocalizedString()
        case .nixieTube:
            return "Digital_tube".KLocalizedString()
        case .sound:
            return "声音".KLocalizedString()
        case .sensirion:
            return "温湿度".KLocalizedString()
        case .motor:
            return "Motor".KLocalizedString()
        case .servo:
            return "Servo".KLocalizedString()
        case .masterboard:
            return "Main_control_box".KLocalizedString()
        }
    }
    
    var upgradeDisplayString:String {
        return "upgrading".KLocalizedString().replacingOccurrences(of: "%s", with: "\(localizedString)")
    }
    
    
    
    //    var version:String?{
    //        if let info = BluetoothManager.shared.currentDevice?.deviceInfo{
    //            switch self {
    //            case .infrared:
    //                return info.infrared?.version
    //            case .touch:
    //                return info.touch?.version
    //            case .led:
    //                return info.led?.version
    //            case .rgbLight:
    //                return info.rgbLight?.version
    //            case .color:
    //                return info.color?.version
    //            case .horn:
    //                return info.horn?.version
    //            case .ultrasound:
    //                return info.ultrasound?.version
    //            case .gyro:
    //                return info.gyro?.version
    //            case .motor:
    //                return info.motor?.version
    //            case .servo:
    //                return info.servo?.version
    //            case .masterboard:
    //                return info.version
    //            default:
    //                return nil
    //            }
    //        }
    //        return nil
    //    }
    
    
    
    //    var normal:[UInt]?{
    //        if let info = BluetoothManager.shared.currentDevice?.deviceInfo{
    //            switch self {
    //            case .infrared:
    //                return info.infrared?.normal
    //            case .touch:
    //                return info.touch?.normal
    //            case .led:
    //                return info.led?.normal
    //            case .rgbLight:
    //                return info.rgbLight?.normal
    //            case .color:
    //                return info.color?.normal
    //            case .horn:
    //                return info.horn?.normal
    //            case .ultrasound:
    //                return info.ultrasound?.normal
    //            case .gyro:
    //                return info.gyro?.normal
    //            case .motor:
    //                return info.motor?.normal
    //            case .servo:
    //                return info.servo?.normal
    //            default:
    //                return nil
    //            }
    //        }
    //        return nil
    //    }
    
    //    var abnormal:[UInt]?{
    //        if let info = BluetoothManager.shared.currentDevice?.deviceInfo{
    //            switch self {
    //            case .infrared:
    //                return info.infrared?.abnormal
    //            case .touch:
    //                return info.touch?.abnormal
    //            case .led:
    //                return info.led?.abnormal
    //            case .rgbLight:
    //                return info.rgbLight?.abnormal
    //            case .color:
    //                return info.color?.abnormal
    //            case .horn:
    //                return info.horn?.abnormal
    //            case .ultrasound:
    //                return info.ultrasound?.abnormal
    //            case .gyro:
    //                return info.gyro?.abnormal
    //            case .motor:
    //                return info.motor?.abnormal
    //            case .servo:
    //                return info.servo?.abnormal
    //            default:
    //                return nil
    //            }
    //        }
    //        return nil
    //    }
    
    
    
    //    var diffVersion:[UInt]?{
    //        if let info = BluetoothManager.shared.currentDevice?.deviceInfo{
    //            switch self {
    //            case .infrared:
    //                return info.infrared?.diffVersion
    //            case .touch:
    //                return info.touch?.diffVersion
    //            case .led:
    //                return info.led?.diffVersion
    //            case .rgbLight:
    //                return info.rgbLight?.diffVersion
    //            case .color:
    //                return info.color?.diffVersion
    //            case .horn:
    //                return info.horn?.diffVersion
    //            case .ultrasound:
    //                return info.ultrasound?.diffVersion
    //            case .gyro:
    //                return info.gyro?.diffVersion
    //            case .motor:
    //                return info.motor?.diffVersion
    //            case .servo:
    //                return info.servo?.diffVersion
    //            default:
    //                return nil
    //            }
    //        }
    //        return nil
    //    }
    
    
}
