//
//  ChessView.swift
//  Imitate_Threes
//
//  Created by 任岐鸣 on 2016/10/14.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit

class ChessView: UIView {
    
    enum whichIsOn {
        case first
        case second
    }
    
    var line = 0
    var col = 0
    
    var whichIsOnTheTop = whichIsOn.first
    //    var lblChessNumber = UILabel.init()
    var firstChess = subChessView()
    var secondChess = subChessView()
    
    var chessNum = 0
    var lastNum = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        
        firstChess = subChessView.init(frame: self.frame)
        secondChess = subChessView.init(frame: self.frame)
        
        addSubview(secondChess)
        addSubview(firstChess)
        
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize.init(width: 4, height: 4)
        
        firstChess.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        secondChess.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setNumber(number:Int,added:Bool,direction: BoardModel.direction) {
        chessNum = number
        if number == 0 {
            firstChess.lblChessNumber.text = ""
            secondChess.lblChessNumber.text = ""
            self.layer.shadowOpacity = 0
            self.alpha = 0
        } else {
            
            
            
            self.layer.shadowOpacity = 0.8
            self.alpha = 1
            if added {
                //                lblChessNumber.alpha = 0
                //                firstChess.lblChessNumber.alpha = 0
                flipToNewNumber(number: number)
            } else {
                switch whichIsOnTheTop {
                case .first:
                    firstChess.lblChessNumber.text = "\(number)"
                case .second:
                    secondChess.lblChessNumber.text = "\(number)"
                }
            }
        }
        if number == 1 {
            self.backgroundColor = UIColor.init(colorLiteralRed: 86/255.0, green: 192/255.0, blue: 254/255.0, alpha: 1)
        } else if number == 2 {
            self.backgroundColor = UIColor.init(colorLiteralRed: 252/255.0, green: 76/255.0, blue: 109/255.0, alpha: 1)
        } else {
            self.backgroundColor = UIColor.white
        }
        
        
        if lastNum == 0 && chessNum != 0 {
            
            let padding = CGFloat(10)
            let offsetY = self.frame.size.height + padding
            let offsetX = self.frame.size.width + padding
            var transform = CGAffineTransform()
            switch direction {
            case .Up:
                guard self.line == 3 else {
                    return
                }
                transform = CGAffineTransform.init(translationX: 0, y: offsetY)
            case .Down:
                guard self.line == 0 else {
                    return
                }
                transform = CGAffineTransform.init(translationX: 0, y: -offsetY)
            case .Left:
                guard self.col == 3 else {
                    return
                }
                transform = CGAffineTransform.init(translationX: offsetX, y: 0)
            case .Right:
                guard self.col == 0 else {
                    return
                }
                transform = CGAffineTransform.init(translationX: -offsetX, y: 0)
            default:
                return
            }
            self.transform = transform
            UIView.animate(withDuration: 0.3, animations: {
                self.transform = CGAffineTransform.init(translationX: 0, y: 0)
            }) { (Bool) in
                //            self.addFinishedClosure?()
            }
        }
        lastNum = number
        
        
    }
    
    func flipToNewNumber(number:Int) {
        
        switch whichIsOnTheTop {
        case .first:
            secondChess.lblChessNumber.text = "\(number)"
            UIView.transition(from: firstChess, to: secondChess, duration: 0.3, options: UIViewAnimationOptions.transitionFlipFromLeft) { (Bool) in
                self.firstChess.lblChessNumber.text = "\(number)"
                self.whichIsOnTheTop = .second
                
                self.secondChess.snp.remakeConstraints { (make) in
                    make.edges.equalTo(self)
                }
                
            }
        case .second:
            firstChess.lblChessNumber.text = "\(number)"
            UIView.transition(from: secondChess, to: firstChess, duration: 0.3, options: UIViewAnimationOptions.transitionFlipFromLeft) { (Bool) in
                self.secondChess.lblChessNumber.text = "\(number)"
                self.whichIsOnTheTop = .first
                
                self.firstChess.snp.remakeConstraints { (make) in
                    make.edges.equalTo(self)
                }
                
            }
        }
    }
    
}
