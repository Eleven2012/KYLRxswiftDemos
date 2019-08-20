//
//  KYLJSApiTest.swift
//  kyl_DSBrigeDemo
//
//  Created by yulu kong on 2019/8/15.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import Foundation

typealias JSCallback = (String,Bool) -> Void

class KYLJSApi: NSObject {
    
    private var value = 10
    private var callback:JSCallback?
    private var timer:Timer?
    
}

extension KYLJSApi {
    @objc public func testSync(_ arg:String) -> String {
        debugPrint("\(#function)")
        return String(format: "%@[Swift sync call:%@]", arg, "test")
    }
    
    @objc public func testAync(_ arg:String, handler: JSCallback) {
        debugPrint("\(#function)")
        handler("\(arg) [Swift async call test] ",true)
    }
    
    @objc public func testNoArgSync(_ args:Dictionary<String,Any>) -> String {
        debugPrint("\(#function)")
        return "带有dic参数的方法"
    }
    
    @objc public func callProgress(_ args:Dictionary<String,Any>, handler:@escaping JSCallback) {
        debugPrint("\(#function)")
        callback  = handler
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(feedbackValue), userInfo: nil, repeats: true)
    }
    
    @objc public func feedbackValue() {
        if let handler = callback {
            if value > 0 {
                handler("\(value)",false)
                value -= 1
            }
            else {
                handler("\(value)",true)
            }
        }
    }
}
