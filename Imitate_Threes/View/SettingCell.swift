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
    func commonInit() {
        self.backgroundColor = UIColor.init(r: 187, g: 217, b: 217, a: 1)
        self.isUserInteractionEnabled = true
        let btnClear = ThreesButton.init(buttonColor: UIColor.gray)
        btnClear.addTarget(self, action:  #selector(clearScores), for: UIControlEvents.touchUpInside)
        btnClear.lblTitle.text = "Clear Scores"
        addSubview(btnClear)
        btnClear.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
    }
    func clearScores() {
        let scores:[Score] = CoreDataTools.sharedInstance.search(entityName: "Score", sort: nil, ascending: true, predicate: nil)!
        for score in scores {
            CoreDataTools.sharedInstance.delete(Object: score)
        }
    }
}
