//
//  KDrawPanView.swift
//  kylDrawDemo
//
//  Created by yulu kong on 2019/10/11.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit

class KDrawPanView: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let color = UIColor.red
        color.set() // 设置线条颜色
        
        let aPath = UIBezierPath(arcCenter: CGPoint(x:150, y:150), radius: 75,
                                 startAngle: 0, endAngle: (CGFloat)(90*M_PI/180), clockwise: true)
        aPath.addLine(to: CGPoint(x:150, y:150))
        aPath.close()
        aPath.lineWidth = 5.0 // 线条宽度
        
        //    aPath.stroke() // Draws line 根据坐标点连线，不填充
        aPath.fill() // Draws line 根据坐标点连线，填充
        
    }
    

}
