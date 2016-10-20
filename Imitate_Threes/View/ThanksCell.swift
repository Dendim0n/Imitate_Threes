//
//  ThanksCell.swift
//  Imitate_Threes
//
//  Created by 任岐鸣 on 16/10/14.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit

class ThanksCell: UICollectionViewCell {
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
        let lblTitle = UILabel.init()
        lblTitle.textAlignment = .center
        lblTitle.text = "Thanks"
        
        let lblList = UILabel.init()
        lblList.numberOfLines = 0
//        lblList.textAlignment = .left
        lblList.text = "GitHub:\nEZSwiftExtensions\nSnapKit\n\n"
        
        addSubview(lblTitle)
        addSubview(lblList)
        
        lblTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(70)
        }
        
        lblList.snp.makeConstraints { (make) in
            make.top.equalTo(lblTitle.snp.bottom).offset(20)
            make.bottom.equalToSuperview().offset(-60)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
    }
}
