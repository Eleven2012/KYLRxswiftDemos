//
//  KYLMProgressHUD.swift
//  kylRxMemoryDemo
//
//  Created by yulu kong on 2019/8/28.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import Foundation
import SVProgressHUD


enum HUDType {
    case success
    case error
    case loading
    case info
    case progress
}


class KYLProgressHUD: NSObject {
    
    class func initKYLProgressHUD() {
        SVProgressHUD.setFont(UIFont.systemFont(ofSize: 14.0))
        SVProgressHUD.setDefaultMaskType(.none)
        SVProgressHUD.setMinimumDismissTimeInterval(1.5)
    }
    
    class func showSucess(_ status: String) {
        self.showKYLProgressHUD(type: .success, status: status)
    }
    
    class func showError(_ status: String) {
        self.showKYLProgressHUD(type: .error, status: status)
    }
    
    class func showLoading(_ status: String) {
        self.showKYLProgressHUD(type: .loading, status: status)
    }
    
    class func showInfo(_ status: String) {
        self.showKYLProgressHUD(type: .info, status: status)
    }
    
    class func showProgress(_ status: String, _ progress: CGFloat) {
        self.showKYLProgressHUD(type: .success, status: status, progress: progress)
    }
    
    class func dismissHUD(_ delay: TimeInterval = 0) {
        SVProgressHUD.dismiss(withDelay: delay)
    }
    
}

// MARK - 扩展ProgressHUD
extension KYLProgressHUD {
    class func showKYLProgressHUD(type: HUDType, status: String, progress: CGFloat =  0)  {
        switch type {
        case .success:
            SVProgressHUD.showSuccess(withStatus: status)
        case .error:
            SVProgressHUD.showError(withStatus: status)
        case .loading:
            SVProgressHUD.show(withStatus: status)
        case .info:
            SVProgressHUD.showInfo(withStatus: status)
        case .progress:
            SVProgressHUD.showProgress(Float(progress), status: status)
        }
    }
}
