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
        self.isUserInteractionEnabled = true
        let btnClear = ThreesButton.init(buttonColor: UIColor.gray)
        btnClear.addTarget(self, action:  #selector(clearScores), for: UIControlEvents.touchUpInside)
        btnClear.titleLabel?.text = "Clear Scores"
        addSubview(btnClear)
        btnClear.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
    }
    func clearScores() {
        print("123321")
    }
}
