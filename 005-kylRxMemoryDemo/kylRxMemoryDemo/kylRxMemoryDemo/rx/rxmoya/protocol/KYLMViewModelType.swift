//
//  KYLViewModelType.swift
//  kylRxMemoryDemo
//
//  Created by yulu kong on 2019/8/28.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import Foundation

protocol KYLMViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
