//
//  KCProxy.swift
//  kylRxMemoryDemo
//
//  Created by yulu kong on 2019/8/24.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import Foundation

class KCProxy: NSObject {
    
    weak var target: NSObjectProtocol?
    var sel: Selector?
    var lgTimer: Timer? = nil
    
    override init() {
        super.init()
    }
    
    func lg_scheduledTimer(timeInterval ti: TimeInterval, target aTarget: Any, selector aSelector: Selector, userInfo: Any?, repeats yesOrNo: Bool){
        
        // vc -> proxy -> timer -> target -> vc
        // vc -> proxy -> target -weak-> self
        
        // proxy aSelector - 我不知道
        
        self.lgTimer = Timer.init(timeInterval: ti, target: self, selector: aSelector, userInfo: userInfo, repeats: yesOrNo)
        RunLoop.current.add(self.lgTimer!, forMode: .common)
        
        self.target = aTarget as? NSObjectProtocol
        self.sel    = aSelector
        
        guard self.target?.responds(to: self.sel) == true else{
            return
        }
        
        let method = class_getInstanceMethod(self.classForCoder, #selector(lgTimerFire))
        class_replaceMethod(self.classForCoder, self.sel!, method_getImplementation(method!), method_getTypeEncoding(method!))
        
    }
    
    
    @objc fileprivate func lgTimerFire(){
        if self.target != nil{
            self.target!.perform(self.sel)
        }
        else{
            self.lgTimer?.invalidate()
            self.lgTimer = nil
        }
    }
    
    override func forwardingTarget(for aSelector: Selector!) -> Any? {
        if self.target?.responds(to: self.sel) == true {
            return self.target
        }
        else{
            print("心里没有点数,写这样的代码,还要我给你填坑")
            return super.forwardingTarget(for: aSelector)
        }
    }
    
    
    deinit {
        print("\(self) 走了")
    }
    
}
