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
        addSubview(lblChessNumber)
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize.init(width: 4, height: 4)
        
        lblChessNumber.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setNumber(number:Int,added:Bool) {
        chessNum = number
        if number == 0 {
            lblChessNumber.text = ""
            self.layer.shadowOpacity = 0
            self.alpha = 0
        } else {
            lblChessNumber.text = "\(number)"
            self.layer.shadowOpacity = 0.8
            self.alpha = 1
            if added {
                flipToNewNumber(number: number)
            }
        }
        if number == 1 {
            self.backgroundColor = UIColor.init(colorLiteralRed: 86/255.0, green: 192/255.0, blue: 254/255.0, alpha: 1)
        } else if number == 2 {
            self.backgroundColor = UIColor.init(colorLiteralRed: 252/255.0, green: 76/255.0, blue: 109/255.0, alpha: 1)
        } else {
            self.backgroundColor = UIColor.white
        }
    }
    
    func flipToNewNumber(number:Int) {
        
        //        CGContextRef context = UIGraphicsGetCurrentContext();
        //        [UIView beginAnimations:nil context:context];
        //        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        //        [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft forView:toView cache:NO];
        //        [UIView setAnimationDuration:0.4];
        
        //        [UIView setAnimationDelegate:self];
        //        [UIView commitAnimations];
        
        let newChess = ChessView.init(frame: self.frame)
        newChess.setNumber(number: number,added: false)
        
        //        var context = UIGraphicsGetCurrentContext()
        //        UIView.beginAnimations(nil, context: context)
        //        UIView.setAnimationCurve(UIViewAnimationCurve.easeInOut)
        //        UIView.setAnimationTransition(UIViewAnimationTransition.flipFromLeft, for: newChess, cache: false)
        //        UIView.setAnimationDuration(0.1)
        //        UIView.setAnimationDelegate(self)
        //        UIView.commitAnimations()
        
        UIView.transition(from: self, to: newChess, duration: 0.1, options: UIViewAnimationOptions.curveEaseInOut) { (Bool) in
            
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
