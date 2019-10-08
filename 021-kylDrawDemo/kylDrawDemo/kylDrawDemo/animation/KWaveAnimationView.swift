//
//  KWaveAnimationView.swift
//  kylDrawDemo
//
//  Created by yulu kong on 2019/10/8.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit
import QuartzCore

// 波浪曲线动画视图
// 波浪曲线公式：y = h * sin(a * x + b); h: 波浪高度， a: 波浪宽度系数， b： 波的移动
class KWaveView: UIView {
    // 波浪高度h
    var waveHeight: CGFloat = 7
    // 波浪宽度系数a
    var waveRate: CGFloat = 0.01
    // 波浪移动速度
    var waveSpeed: CGFloat = 0.05
    // 真实波浪颜色
    var realWaveColor: UIColor = UIColor(55, 153, 249)
    // 阴影波浪颜色
    var maskWaveColor: UIColor = UIColor(55, 153, 249, 0.3)
    // 波浪位置（默认是在下方）
    var waveOnBottom = true
    // 波浪移动回调
    var closure: ((_ centerY: CGFloat)->())?
    
    // 定时器
    private var displayLink: CADisplayLink?
    // 真实波浪
    private var realWaveLayer: CAShapeLayer?
    // 阴影波浪
    private var maskWaveLayer: CAShapeLayer?
    // 波浪的偏移量
    private var offset: CGFloat = 0
    
    // 视图初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWaveParame()
    }
    
    // 视图初始化
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWaveParame()
    }
    
    // 组件初始化
    private func initWaveParame() {
        // 真实波浪配置
        realWaveLayer = CAShapeLayer()
        var frame = bounds
        realWaveLayer?.frame.origin.y = frame.size.height - waveHeight
        frame.size.height = waveHeight
        realWaveLayer?.frame = frame
        
        // 阴影波浪配置
        maskWaveLayer = CAShapeLayer()
        maskWaveLayer?.frame.origin.y = frame.size.height - waveHeight
        frame.size.height = waveHeight
        maskWaveLayer?.frame = frame
        
        layer.addSublayer(maskWaveLayer!)
        layer.addSublayer(realWaveLayer!)
    }
    
    // 开始播放动画
    func startWave() {
        // 开启定时器
        displayLink = CADisplayLink(target: self, selector: #selector(self.wave))
        displayLink!.add(to: RunLoop.current, forMode: RunLoop.Mode.common)
    }
    
    // 停止播放动画
    func endWave() {
        // 结束定时器
        displayLink!.invalidate()
        displayLink = nil
    }
    
    // 定时器响应（每一帧都会调用一次）
    @objc func wave() {
        // 波浪移动的关键：按照指定的速度偏移
        offset += waveSpeed
        
        // 起点y坐标（没有波浪的一侧）
        let startY = self.waveOnBottom ? 0 : frame.size.height
        
        let realPath = UIBezierPath()
        realPath.move(to: CGPoint(x: 0, y: startY))
        
        let maskPath = UIBezierPath()
        maskPath.move(to: CGPoint(x: 0, y: startY))
        
        var x = CGFloat(0)
        var y = CGFloat(0)
        while x <= bounds.size.width {
            // 波浪曲线
            y = waveHeight * sin(x * waveRate + offset)
            // 如果是下波浪还要加上视图高度
            let realY = y + (self.waveOnBottom ? frame.size.height : 0)
            let maskY = -y + (self.waveOnBottom ? frame.size.height : 0)
            
            realPath.addLine(to: CGPoint(x: x, y: realY))
            maskPath.addLine(to: CGPoint(x: x, y: maskY))
            
            // 增量越小，曲线越平滑
            x += 0.1
        }
        
        let midX = bounds.size.width * 0.5
        let midY = waveHeight * sin(midX * waveRate + offset)
        
        if let closureBack = closure {
            closureBack(midY)
        }
        // 回到起点对侧
        realPath.addLine(to: CGPoint(x: frame.size.width, y: startY))
        maskPath.addLine(to: CGPoint(x: frame.size.width, y: startY))
        
        // 闭合曲线
        maskPath.close()
        
        // 把封闭图形的路径赋值给CAShapeLayer
        maskWaveLayer?.path = maskPath.cgPath
        maskWaveLayer?.fillColor = maskWaveColor.cgColor
        
        realPath.close()
        realWaveLayer?.path = realPath.cgPath
        realWaveLayer?.fillColor = realWaveColor.cgColor
    }
}

