//
//  KPhotoCell.swift
//  kylRxMemoryDemo
//
//  Created by yulu kong on 2019/8/24.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit

class KTVPhotoCell: UICollectionViewCell {
    lazy var imageView: UIImageView = {
        let image = UIImageView(frame: self.contentView.bounds)
        image.isUserInteractionEnabled = true
        return image
    }()
    
    lazy var checkmark: UIImageView = {
        let frame = self.contentView.bounds
        let size  = CGFloat(30)
        let image = UIImageView(frame: CGRect(x: frame.size.width-size, y: frame.size.height-size, width: size, height: size))
        image.isUserInteractionEnabled = true
        image.image = UIImage(named: "check_selected")
        image.alpha = 0
        return image
    }()
    
    var representedAssetIdentifier: String!
    var isCheckmarked: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.addSubview(checkmark)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func flipCheckmark() {
        self.isCheckmarked = !self.isCheckmarked
    }
    
    func selected() {
        self.flipCheckmark()
        setNeedsDisplay()
        UIView.animate(withDuration: 0.1) {
            self.checkmark.alpha = self.isCheckmarked ? 1 : 0
        }
    }
}
