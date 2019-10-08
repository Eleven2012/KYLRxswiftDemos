//
//  CRC32.swift
//  kylRxBluetoothDemo
//
//  Created by yulu kong on 2019/9/19.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import Foundation


final class CRC32 {
    
    let table: [UInt32]
    
    init() {
        var table: [UInt32] = [UInt32](repeating: 0x00000000, count: 256)
        for i in 0..<table.count {
            var crc: UInt32 = UInt32(i)
            for _ in 0..<8 {
                
                if (crc & 1 == 1){
                    crc = (crc >> 1) ^ 0xEDB88320
                }else{
                    crc >>= 1
                }
            }
            table[i] = crc
        }
        self.table = table
    }
    
    func calculate(_ data: Data) -> UInt32 {
        var crc: UInt32 = 0xffffffff
        for i in 0..<data.count {
            crc = table[Int((crc ^ UInt32(data[i])) & 0xff)] ^ (crc >> 8)
        }
        return crc
    }
    
    static func format(data:Data)->Data{
        var d = data
        let mod = data.count % 64
        
        if mod != 0 {
            d.append(Data(bytes:[UInt8](repeating: 0, count: 64 - mod)))
        }
        
        return d
    }
}
