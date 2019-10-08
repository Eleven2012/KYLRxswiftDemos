//
//  String+Language.swift
//  kylRxBluetoothDemo
//
//  Created by yulu kong on 2019/9/19.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import Foundation

extension String {
    
    func KLocalizedString(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }

}
