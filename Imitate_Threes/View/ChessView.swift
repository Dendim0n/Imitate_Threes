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
    
    var scoreDic:Dictionary<Double,Double> = [1:0,2:0]
    
    var line = 0
    var col = 0
    
    var whichIsOnTheTop = whichIsOn.first
    //    var lblChessNumber = UILabel.init()
    var firstChess = subChessView()
    var secondChess = subChessView()
    
    var lblPoint = UILabel.init()
    
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
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    private func commonInit() {
        for k in 1...20 {
            scoreDic[Double(3)*pow(2.0, Double(k-1))] = pow(3.0, Double(k))
        }
        self.layer.cornerRadius = 4
        
        firstChess = subChessView.init(frame: self.frame)
        secondChess = subChessView.init(frame: self.frame)
        lblPoint.font = UIFont.Font(FontName.Seravek, type: FontType.Bold, size: 12)
        lblPoint.transform = CGAffineTransform.init(scaleX: 0, y: 0)
        lblPoint.textAlignment = .center
        addSubview(secondChess)
        addSubview(firstChess)
        addSubview(lblPoint)
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize.init(width: 4, height: 4)
        
        firstChess.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        secondChess.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        lblPoint.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(self.snp.width)
            make.centerX.equalTo(self.snp.right)
            make.centerY.equalTo(self.snp.top)
        }
    }
    
    func setNumber(number:Int,added:Bool,direction: BoardModel.direction) {
        chessNum = number
        if number == 0 {
            firstChess.lblChessNumber.text = ""
            secondChess.lblChessNumber.text = ""
            lblPoint.text = ""
            self.layer.shadowOpacity = 0
            self.alpha = 0
        } else {
            if number != 1 && number != 2 {
                lblPoint.text = "\(Int(scoreDic[Double(number)]!))"
            }
            
            self.layer.shadowOpacity = 0.8
            self.alpha = 1
            if added {
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
            var transform = CGAffineTransform.init(translationX: 0, y: 0)
            switch direction {
            case .up:
                guard self.line == 3 else {
                    lastNum = number
                    return
                    //                    break
                }
                transform = CGAffineTransform.init(translationX: 0, y: offsetY)
            case .down:
                guard self.line == 0 else {
                    lastNum = number
                    return
                    //                    break
                }
                transform = CGAffineTransform.init(translationX: 0, y: -offsetY)
            case .left:
                guard self.col == 3 else {
                    lastNum = number
                    return
                    //                    break
                }
                transform = CGAffineTransform.init(translationX: offsetX, y: 0)
            case .right:
                guard self.col == 0 else {
                    lastNum = number
                    return
                    //                    break
                }
                transform = CGAffineTransform.init(translationX: -offsetX, y: 0)
            default:
                lastNum = number
                return
            }
            self.transform = transform
            UIView.animate(withDuration: 0.3, animations: {
                self.transform = CGAffineTransform.init(translationX: 0, y: 0)
            }) { (Bool) in
                //            self.addFinishedClosure?()
            }
            lastNum = number
        } else {
            lastNum = number
        }
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
    
    func showPoint() {
        lblPoint.transform = CGAffineTransform.init(scaleX: 1, y: 1)
    }
    
}
