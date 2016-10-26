//
//  ScoreCell.swift
//  Imitate_Threes
//
//  Created by 任岐鸣 on 16/10/14.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit

class ScoreCell: UICollectionViewCell {
    
    var board = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
    var score = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //        commonInit()
    }
    
    
    func commonInit() {
        self.backgroundColor = .white
        let gameBoard = BoardView.init(frame: self.frame)
        addSubview(gameBoard)
        gameBoard.snp.makeConstraints { (make) in
            //            make.edges.equalToSuperview()
            make.top.equalToSuperview().offset(25)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        gameBoard.setRealChess()
        for i in 0...3 {
            for j in 0...3 {
                let chess = gameBoard.chesses[i][j]
                chess.lastNum = board[i][j]
                chess.setNumber(number:board[i][j],added:false,direction: BoardModel.direction.none)
                chess.addShadow(offset: CGSize.zero, radius: 0, color: UIColor.black, opacity: 1)
            }
        }
        let liftPoint = CGRect.init(x: self.frame.size.width / 2 - 5, y: 0, w: 10, h: 10)
        let midPoint = CGPoint.init(x: self.frame.size.width / 2, y: 5)
        let lineStartPoint = CGPoint.init(x: 20, y: 25)
        let lineEndPoint = CGPoint.init(x: self.frame.size.width - 20, y: 25)
        let liftLayer = CAShapeLayer()
        liftLayer.strokeColor = UIColor.green.cgColor
        liftLayer.fillColor = UIColor.green.cgColor
        liftLayer.frame = CGRect.init(x: 0, y: 0, w: self.frame.size.width, h: self.frame.size.height)
        let point = UIBezierPath.init(ovalIn: liftPoint)
        liftLayer.path = point.cgPath
        
        
        let lineLayer = CAShapeLayer()
        lineLayer.strokeColor = UIColor.gray.cgColor
        let line = UIBezierPath()
        line.lineCapStyle = .round
        line.lineJoinStyle = .round
        line.move(to: lineStartPoint)
        line.addLine(to: midPoint)
        line.move(to: midPoint)
        line.addLine(to: lineEndPoint)
        lineLayer.path = line.cgPath
        lineLayer.lineWidth = 3
        layer.addSublayer(lineLayer)
        layer.addSublayer(liftLayer)
        
        setAnchorPoint(point: CGPoint.init(x: 0.5, y: 5/self.frame.height), view: self)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let angle:CGFloat = CGFloat(M_PI) / 24
        //        self.layer.anchorPoint = CGPoint.init(x: self.frame.size.width / 2, y: 5)
        print(self.frame)
//        setAnchorPoint(point: CGPoint.init(x: 0.5, y: 5/self.frame.height), view: self)
        self.transform = CGAffineTransform.init(rotationAngle: angle)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: UIViewAnimationOptions.allowAnimatedContent, animations: {
            self.transform = CGAffineTransform.init(rotationAngle: 0)
            }, completion: {
                Void in
                self.layer.removeAllAnimations()
        })
    
    }
    
    func setAnchorPoint(point:CGPoint,view:UIView){
        let oldFrame = view.frame;
        view.layer.anchorPoint = point;
        view.frame = oldFrame;
    }
    
    
}
