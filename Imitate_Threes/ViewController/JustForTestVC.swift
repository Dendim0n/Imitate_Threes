//
//  JustForTestVC.swift
//  Imitate_Threes
//
//  Created by 任岐鸣 on 2016/10/10.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit

class JustForTestVC: UIViewController {
    
    var swipe = UISwipeGestureRecognizer.init()
    let testModel = BoardModel()
    let testBoard = BoardView.init()
    var swipeDirection = BoardModel.direction.None
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testModel.initBoard()
        weak var weakSelf = self
        
        testModel.initClosure(startClosure: { (Void) in
            for ges in (weakSelf?.testBoard.gestureRecognizers!)! {
                ges.isEnabled = false
            }
        }) { (Void) in
            for ges in (weakSelf?.testBoard.gestureRecognizers!)! {
                ges.isEnabled = true
            }
        }
        
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
            } else if (gesture.state == UIGestureRecognizerState.changed && weakSelf?.swipeDirection == BoardModel.direction.None) {
                weakSelf?.swipeDirection = (weakSelf?.determineSwipeDirection(translation: gesture.translation(in: weakSelf?.testBoard)))!
            } else if (gesture.state == UIGestureRecognizerState.ended) {
                weakSelf?.testModel.move(direction: (weakSelf?.swipeDirection)!)
                weakSelf?.sync()
            }
        }
        sync()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        testBoard.setRealChess()
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
