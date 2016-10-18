//
//  ChessView.swift
//  Imitate_Threes
//
//  Created by 任岐鸣 on 2016/10/10.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit

class subChessView: UIView {
    
    var line = 0
    var col = 0
    
    var lblChessNumber = UILabel.init()
    var chessNum = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        lblChessNumber.font = UIFont.Font(FontName.Seravek, type: FontType.Bold, size: 24)
        lblChessNumber.textAlignment = NSTextAlignment.center
        lblChessNumber.frame = self.frame
        addSubview(lblChessNumber)
        
        lblChessNumber.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setNumber(_ number:Int) {
        chessNum = number
        if number == 0 {
            lblChessNumber.text = ""
        } else {
            lblChessNumber.text = "\(number)"
        }
        if number == 1 {
            self.backgroundColor = UIColor.init(colorLiteralRed: 86/255.0, green: 192/255.0, blue: 254/255.0, alpha: 1)
        } else if number == 2 {
            self.backgroundColor = UIColor.init(colorLiteralRed: 252/255.0, green: 76/255.0, blue: 109/255.0, alpha: 1)
        } else {
            self.backgroundColor = UIColor.white
        }
    }
    func updateLabelConstraints() {
        lblChessNumber.snp.removeConstraints()
        lblChessNumber.frame = self.frame
    }
    
}
