//
//  KTestProxyVC.swift
//  kylRxMemoryDemo
//
//  Created by yulu kong on 2019/8/24.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit

class KTestProxyVC: UIViewController {

    var lgTimer: Timer?
    let proxy: KCProxy = KCProxy()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 中介者 - map - MAP
        // proxy
        //        lgTimer = Timer.init(timeInterval: 1, target: proxy, selector: #selector(timerFire), userInfo: nil, repeats: true)
        //
        //        lgTimer = Timer.init(timeInterval: 1, repeats: true, block: { (timer) in
        //            print("timer fire \(timer)")
        //        })
        //        RunLoop.current.add(lgTimer!, forMode: .common)
        
        let selector = NSSelectorFromString("timerFire")
        
        proxy.lg_scheduledTimer(timeInterval: 1, target: self, selector: selector, userInfo: nil, repeats: true)
        
        // self -> proxy -weak-> target -> self
        
        // self -> timer -> proxy
        // RunLoop.current -> timer
    }
    
    @objc func timerFire(){
        print("timer fire")
    }
    
    deinit {
        print("\(self) 走了")
    }
}
