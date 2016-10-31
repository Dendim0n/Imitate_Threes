//
//  NextChessView.swift
//  Imitate_Threes
//
//  Created by 任岐鸣 on 2016/10/18.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit

class NextChessView: UIView {
    var chess = subChessView.init(frame: CGRect.zero)
    var number = 0
    
    init(num:Int) {
        super.init(frame: CGRect.zero)
        number = num
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        addSubview(chess)
        self.backgroundColor = .clear
        chess.layer.shadowRadius = 2
        chess.layer.shadowOffset = CGSize.init(width: 2, height: 2)
        chess.layer.shadowOpacity = 0.80
        chess.backgroundColor = .white
        chess.layer.cornerRadius = 2
        chess.setNumber(number)
        chess.snp.makeConstraints { (make) in
            make.height.equalToSuperview()
            make.width.equalTo(chess.snp.height).multipliedBy(0.625)
            make.center.equalToSuperview()
        }
    }

    override func draw(_ rect: CGRect) {
        // Drawing code
        chess.transform = CGAffineTransform.init(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 5, initialSpringVelocity: 5, options: UIViewAnimationOptions.allowUserInteraction, animations: { 
            self.chess.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }, completion: nil)
    }
    

}
