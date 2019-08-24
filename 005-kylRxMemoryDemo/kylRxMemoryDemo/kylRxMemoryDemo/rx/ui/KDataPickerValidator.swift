//
//  KDataPickerValidator.swift
//  kylRxMemoryDemo
//
//  Created by yulu kong on 2019/8/24.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit

class KDataPickerValidator: NSObject {
    
    // 选择的日期是否小于当天；
    class func isValidDate(date: Date) -> Bool{
        let calendar = NSCalendar.current
        let compare  = calendar.compare(date,
                                        to: Date.init(),
                                        toGranularity: .day)
        return compare == .orderedAscending
    }
    
}
