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
        testBoard.addSwipeGesture(direction: UISwipeGestureRecognizerDirection.up) { (swipe) in
            weakSelf?.testModel.move(direction: .Up)
            weakSelf?.sync()
        }
        testBoard.addSwipeGesture(direction: UISwipeGestureRecognizerDirection.down) { (swipe) in
            weakSelf?.testModel.move(direction: .Down)
            weakSelf?.sync()
        }
        testBoard.addSwipeGesture(direction: UISwipeGestureRecognizerDirection.left) { (swipe) in
            weakSelf?.testModel.move(direction: .Left)
            weakSelf?.sync()
        }
        testBoard.addSwipeGesture(direction: UISwipeGestureRecognizerDirection.right) { (swipe) in
            weakSelf?.testModel.move(direction: .Right)
            weakSelf?.sync()
        }
        sync()
        
    }
    
    func sync() {
        for i in 0...3 {
            for j in 0...3 {
                testBoard.hiddenChesses[i][j].setNumber(number: testModel.board[i][j])
                
            }
        }
    }

}
