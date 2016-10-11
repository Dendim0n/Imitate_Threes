//
//  JustForTestVC.swift
//  Imitate_Threes
//
//  Created by 任岐鸣 on 2016/10/10.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit

class JustForTestVC: UIViewController {
    
//    var displayLink = CADisplayLink()
    
    
    var swipe = UISwipeGestureRecognizer.init()
    let testModel = BoardModel()
    let testBoard = BoardView.init()
    var swipeDirection = BoardModel.direction.None

    var currentPoint = CGPoint.init(x: 0, y: 0)
    
    override func viewDidLoad() {
        
//        displayLink = CADisplayLink.init(target: self, selector: #selector(moveChesses))
//        displayLink.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
//        
        super.viewDidLoad()
        
        testModel.initBoard()
        weak var weakSelf = self
        
//        testModel.initClosure(startClosure: { (Void) in
//            for ges in (weakSelf?.testBoard.gestureRecognizers!)! {
////                ges.isEnabled = false
//            }
//        }) { (Void) in
//            for ges in (weakSelf?.testBoard.gestureRecognizers!)! {
////                ges.isEnabled = true
//            }
//        }
        
        view.addSubview(testBoard)
        testBoard.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
            make.top.equalToSuperview().offset(50)
            make.bottom.equalToSuperview().offset(-50)
        }
        testBoard.addPanGesture { (gesture) in
            if (gesture.state == UIGestureRecognizerState.began) {
                weakSelf?.swipeDirection = .None
                
            } else if (gesture.state == UIGestureRecognizerState.changed) {
                weakSelf?.swipeDirection = (weakSelf?.determineSwipeDirection(translation: gesture.translation(in: weakSelf?.testBoard)))!
                weakSelf?.currentPoint = gesture.translation(in: weakSelf?.testBoard)
                weakSelf?.moveChesses(point: gesture.translation(in: weakSelf?.testBoard))
//                print("translation.x is \(gesture.translation(in: weakSelf?.testBoard))")
            } else if (gesture.state == UIGestureRecognizerState.ended) {
                weakSelf?.testModel.move(direction: (weakSelf?.swipeDirection)!)
                weakSelf?.moveChesses(point: CGPoint.init(x: 0, y: 0))
                weakSelf?.sync()
            }
        }
        sync()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        testBoard.setRealChess()
    }
    
    func moveChesses(point:CGPoint) {
//        let point = self.currentPoint
//        print(point)
        let chessFrame = testBoard.chesses[0][0].frame
        var transform:CGAffineTransform
        switch self.swipeDirection {
        case .Up:
            transform = CGAffineTransform(translationX: 0, y: max(point.y,-chessFrame.size.height - 10))
        case .Down:
            transform = CGAffineTransform(translationX: 0, y: min(point.y,chessFrame.size.height + 10))
        case .Left:
            transform = CGAffineTransform(translationX: max(point.x,-chessFrame.size.width - 10), y: 0)
        case .Right:
            transform = CGAffineTransform(translationX: min(point.x,chessFrame.size.width + 10), y: 0)
        default:
            return
        }
        
        testBoard.moveRealChesses(transform: transform)
        
    }
    
    func sync() {
        for i in 0...3 {
            for j in 0...3 {
                testBoard.hiddenChesses[i][j].setNumber(number: testModel.board[i][j])
                
            }
        }
    }
    
    func determineSwipeDirection(translation:CGPoint) ->
        BoardModel.direction {
            let gestureMinimumTranslation = 20.0
            
            if swipeDirection != .None {
                return swipeDirection
            }
            if (fabs(translation.x) > CGFloat(gestureMinimumTranslation)) {
                
                var gestureHorizontal = false
                
                if translation.y == 0.0 {
                    gestureHorizontal = true
                } else {
                    gestureHorizontal = (fabs(translation.x / translation.y) > 5.0)
                }
                
                if gestureHorizontal {
                    if translation.x > 0.0 {
                        return .Right
                    } else {
                        return .Left
                    }
                }
            } else if (fabs(translation.y) > CGFloat(gestureMinimumTranslation)) {
                if translation.y > 0.0 {
                    return .Down
                } else {
                    return .Up
                }
            }
            return swipeDirection
    }
    
}
