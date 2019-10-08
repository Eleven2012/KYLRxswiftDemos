//
//  KDrawRectView.swift
//  kylDrawDemo
//
//  Created by yulu kong on 2019/10/8.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit

class KDrawRect:UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //设置背景色为透明，否则是黑色背景
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        //获取绘图上下文
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }

        //绘制实线
        //drawRect(context: context)
        
        //绘制虚线
        //drawDarkRect(context: context)
        
        //绘制圆弧
        //drawCircle(context: context)
        
        //绘制二次贝塞尔曲线
        //drawBezierCurve2(context: context)
        
        //绘制三次贝塞尔曲线
        drawBezierCurve3(context: context)
    }
    

}

// MARK - 绘制实线
extension KDrawRect {
    func drawRect(context: CGContext) {
        //创建一个矩形，它的所有边都内缩3
        let drawingRect = self.bounds.insetBy(dx: 3, dy: 3)
        
        //创建并设置路径
        let path = CGMutablePath()
        path.move(to: CGPoint(x:drawingRect.minX, y:drawingRect.minY))
        path.addLine(to:CGPoint(x:drawingRect.maxX, y:drawingRect.minY))
        path.addLine(to:CGPoint(x:drawingRect.maxX, y:drawingRect.maxY))
        
        //添加路径到图形上下文
        context.addPath(path)
        
        //设置笔触颜色
        context.setStrokeColor(UIColor.orange.cgColor)
        //设置笔触宽度
        context.setLineWidth(6)
        
        //绘制路径
        context.strokePath()
    }
}

// MARK - 绘制虚线
extension KDrawRect {
    func drawDarkRect(context: CGContext) {
        //创建一个矩形，它的所有边都内缩3
        let drawingRect = self.bounds.insetBy(dx: 3, dy: 3)
        
        //创建并设置路径
        let path = CGMutablePath()
        path.move(to: CGPoint(x:drawingRect.minX, y:drawingRect.minY))
        path.addLine(to:CGPoint(x:drawingRect.maxX, y:drawingRect.minY))
        path.addLine(to:CGPoint(x:drawingRect.maxX, y:drawingRect.maxY))
        
        //添加路径到图形上下文
        context.addPath(path)
        
        //设置笔触颜色
        context.setStrokeColor(UIColor.orange.cgColor)
        //设置笔触宽度
        context.setLineWidth(6)
        
        //虚线每个线段的长度与间隔
        let lengths: [CGFloat] = [15,4]
        //设置虚线样式
        context.setLineDash(phase: 0, lengths: lengths)
        
        //绘制路径
        context.strokePath()
    }
}

// MARK - 绘制圆弧
extension KDrawRect {
    func drawCircle(context: CGContext) {
        //创建一个矩形，它的所有边都内缩3
        let drawingRect = self.bounds.insetBy(dx: 3, dy: 3)
        
        //创建并设置路径
        let path = CGMutablePath()
        
        //圆弧半径
        let radius = min(drawingRect.width, drawingRect.height)/2
        //圆弧中点
        let center = CGPoint(x:drawingRect.midX, y:drawingRect.midY)
        //绘制圆弧
        path.addArc(center: center, radius: radius, startAngle: 0,
                    endAngle: CGFloat.pi * 1.5, clockwise: false)
        
        //添加路径到图形上下文
        context.addPath(path)
        
        //设置笔触颜色
        context.setStrokeColor(UIColor.orange.cgColor)
        //设置笔触宽度
        context.setLineWidth(6)
        
        //绘制路径
        context.strokePath()

    }
}

// MARK - 绘制贝塞尔曲线
extension KDrawRect {
    //绘制二次贝塞尔曲线
    func drawBezierCurve2(context: CGContext) {
        //创建一个矩形，它的所有边都内缩3点
        let drawingRect = self.bounds.insetBy(dx: 3, dy: 3)
        
        //创建并设置路径
        let path = CGMutablePath()
        //移动起点
        path.move(to: CGPoint(x: drawingRect.minX, y: drawingRect.maxY))
        //二次贝塞尔曲线终点
        let toPoint = CGPoint(x: drawingRect.maxX, y: drawingRect.maxY)
        //二次贝塞尔曲线控制点
        let controlPoint = CGPoint(x: drawingRect.midX, y: drawingRect.minY)
        //绘制二次贝塞尔曲线
        path.addQuadCurve(to: toPoint, control: controlPoint)
        
        //添加路径到图形上下文
        context.addPath(path)
        
        //设置笔触颜色
        context.setStrokeColor(UIColor.orange.cgColor)
        //设置笔触宽度
        context.setLineWidth(6)
        
        //绘制路径
        context.strokePath()

    }
    
    //绘制三次贝塞尔曲线
    func drawBezierCurve3(context: CGContext) {
        //创建一个矩形，它的所有边都内缩3
        let drawingRect = self.bounds.insetBy(dx: 3, dy: 3)
        
        //创建并设置路径
        let path = CGMutablePath()
        //移动起点
        path.move(to: CGPoint(x: drawingRect.minX, y: drawingRect.maxY))
        //三次贝塞尔曲线终点
        let toPoint = CGPoint(x: drawingRect.maxX, y: drawingRect.minY)
        //三次贝塞尔曲线第1个控制点
        let controlPoint1 = CGPoint(x: (drawingRect.minX+drawingRect.midX)/2, y: drawingRect.minY)
        //三次贝塞尔曲线第2个控制点
        let controlPoint2 = CGPoint(x: (drawingRect.midX+drawingRect.maxX)/2, y: drawingRect.maxY)
        //绘制三次贝塞尔曲线
        path.addCurve(to: toPoint, control1: controlPoint1, control2: controlPoint2)
        
        //添加路径到图形上下文
        context.addPath(path)
        
        //设置笔触颜色
        context.setStrokeColor(UIColor.orange.cgColor)
        //设置笔触宽度
        context.setLineWidth(6)
        
        //绘制路径
        context.strokePath()

    }
}

