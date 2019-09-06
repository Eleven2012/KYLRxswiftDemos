//
//  ViewController.swift
//  kylUIFitSizeDemo
//
//  Created by yulu kong on 2019/9/6.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit
import SwiftyFitsize
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        testStrechImage()
        testStrechImage2()
    }

    private func setupUI() {
        testSwiftFitsize()
    }
    
    private lazy var fitLabel : UILabel = {
        let lab = UILabel()
        lab.font = UIFont.boldSystemFont(ofSize: 25)~
        lab.text = "屏幕大小：(w=\(screenWidth),h=\(screenHeight))"
        return lab
    }()
    
    private lazy var fitView : UIView = {
       let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    private lazy var testImageView:UIImageView = {
       let imgView = UIImageView()
        return imgView
    }()
    
    private lazy var testIpadImageView:UIImageView = {
        let imgView = UIImageView()
        return imgView
    }()
}

// MARK - SwiftFitsize使用
extension ViewController {
    private func testSwiftFitsize() {
        view.addSubview(fitLabel)
        view.addSubview(fitView)
        
        fitLabel.sizeToFit()
        let fitLabelX: CGFloat = 15
        let fitLabelY: CGFloat = 100
        var frame = fitLabel.frame
        frame.origin.x = fitLabelX~
        frame.origin.y = fitLabelY~
        fitLabel.frame = frame
        
        let redViewFrame = CGRect(
            x: fitLabelX,
            y: fitLabelY + 50,
            width: 100,
            height: 100)
        fitView.frame = redViewFrame~
        
        let fitsizeView = FitsizeView()
        self.view.addSubview(fitsizeView)
        fitsizeView.frame = CGRect(x: 0, y: redViewFrame~.maxY, width: 328~, height: 298~)
    }
}

// MARK - 图片拉伸
extension ViewController {
    private func testStrechImage() {
        view.addSubview(testImageView)
        testImageView.snp.makeConstraints { (make) in
            make.top.equalTo(fitView.snp.bottom).offset(20~)
            make.left.equalToSuperview().offset(30~)
            make.right.equalToSuperview().offset(-30~)
            make.height.equalTo(80~)
        }
        testImageView.image = ViewController.stretchFromCenter(image: UIImage(named: "talk_bg"))
    }
    
    private func testStrechImage2() {
        view.addSubview(testIpadImageView)
        testIpadImageView.snp.makeConstraints { (make) in
            make.top.equalTo(testImageView.snp.bottom).offset(20≈)
            make.left.equalToSuperview().offset(30≈)
            make.right.equalToSuperview().offset(-30≈)
            make.height.equalTo(80≈)
        }
        testIpadImageView.image = ViewController.stretchFromCenter(image: UIImage(named: "talk_bg"))
    }
    /// 从中间拉伸图片
    ///
    /// - Parameter image: 拉伸之前原始图
    /// - Returns: 拉伸后图片
    static func stretchFromCenter(image: UIImage?) -> UIImage? {
        guard let oriImage = image else {
            return nil
        }
        let result = oriImage.resizableImage(withCapInsets: UIEdgeInsets(top: oriImage.size.height/2, left: oriImage.size.width/2, bottom: oriImage.size.height/2, right: oriImage.size.width/2), resizingMode: .stretch)
        return result
    }

}

