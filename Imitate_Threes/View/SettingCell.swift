//
//  SettingCell.swift
//  Imitate_Threes
//
//  Created by 任岐鸣 on 16/10/14.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit

class SettingCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    func commonInit() {
        
    }
}
