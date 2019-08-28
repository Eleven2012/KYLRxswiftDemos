//
//  KYLMTableViewCell.swift
//  kylRxMemoryDemo
//
//  Created by yulu kong on 2019/8/28.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit
import Reusable

class KYLMTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var picView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension KYLMTableViewCell {
    static func cellHeigh() -> CGFloat {
        return 240
    }
}
