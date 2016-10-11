//
//  ChessView.swift
//  Imitate_Threes
//
//  Created by 任岐鸣 on 2016/10/10.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit

class ChessView: UIView {
    
    var lblChessNumber = UILabel.init()
    
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
        addSubview(lblChessNumber)
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize.init(width: 4, height: 4)
       
        lblChessNumber.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setNumber(number:Int) {
        if number == 0 {
            lblChessNumber.text = ""
             self.layer.shadowOpacity = 0
        } else {
            lblChessNumber.text = "\(number)"
             self.layer.shadowOpacity = 0.8
        }
        if number == 1 {
            self.backgroundColor = UIColor.init(colorLiteralRed: 86/255.0, green: 192/255.0, blue: 254/255.0, alpha: 1)
        } else if number == 2 {
            self.backgroundColor = UIColor.init(colorLiteralRed: 252/255.0, green: 76/255.0, blue: 109/255.0, alpha: 1)
        } else {
            self.backgroundColor = UIColor.white
        }
    }
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
