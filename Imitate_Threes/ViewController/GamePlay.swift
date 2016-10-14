//
//  JustForTestVC.swift
//  Imitate_Threes
//
//  Created by 任岐鸣 on 2016/10/10.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit

class GamePlay: UIViewController {
    
    var displayLink = CADisplayLink()
    var swipe = UISwipeGestureRecognizer.init()
    let chessModel = BoardModel()
    let gameBoard = BoardView.init()
    var swipeDirection = BoardModel.direction.None
    var currentPoint = CGPoint.init(x: 0, y: 0)
    var currentTranslationPercent = 0.0
    var movableChesses = Array<Array<Bool>>()
    var transform = CGAffineTransform()
    
    var plusChesses = Array(repeatElement(Array(repeatElement(false, count: 4)), count: 4))

    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        chessModel.initBoard()
        weak var weakSelf = self
        gameBoard.finishedClosure = {
            Void in
            self.sync()
            self.chessModel.addNewChess()
        }
        chessModel.doAdded = {
            Void in
            self.sync()
        }
        chessModel.doMoved = {
            array in
            //add flip-to-plus animation
            
            self.plusChesses = array

        }
        view.addSubview(gameBoard)
        gameBoard.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
            make.top.equalToSuperview().offset(50)
            make.bottom.equalToSuperview().offset(-50)
        }
        gameBoard.addPanGesture { (gesture) in
            if (gesture.state == UIGestureRecognizerState.began) {
                weakSelf?.swipeDirection = .None
                self.displayLink = CADisplayLink.init(target: self, selector: #selector(self.moveChesses))
                weakSelf?.displayLink.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
            } else if (gesture.state == UIGestureRecognizerState.changed) {

            } else if (gesture.state == UIGestureRecognizerState.ended) {
                print("end")
                weakSelf?.displayLink.remove(from: RunLoop.current, forMode: RunLoopMode.commonModes)
                if self.currentTranslationPercent > 0.6 || self.currentTranslationPercent < -0.6 {
                    
                    DispatchQueue.global().async {
                        weakSelf?.chessModel.move(direction: (weakSelf?.swipeDirection)!)
                        DispatchQueue.main.async(execute: { 
                            
                            let chessFrame = weakSelf?.gameBoard.chesses[0][0].frame
                            let padding = 10.0
                            let horizontal = Double((chessFrame?.size.width)!) + padding
                            let vertical = Double((chessFrame?.size.height)!) + padding
                            
                            switch self.swipeDirection {
                            case .Up:
                                weakSelf?.transform = CGAffineTransform(translationX: 0, y: CGFloat(-vertical))
                                weakSelf?.movableChesses = (weakSelf?.chessModel.upMovableChesses)!
                            case .Down:
                                weakSelf?.transform = CGAffineTransform(translationX: 0, y: CGFloat(vertical))
                                weakSelf?.movableChesses = (weakSelf?.chessModel.downMovableChesses)!
                            case .Left:
                                weakSelf?.transform = CGAffineTransform(translationX: CGFloat(-horizontal), y: 0)
                                weakSelf?.movableChesses = (weakSelf?.chessModel.leftMovableChesses)!
                            case .Right:
                                weakSelf?.transform = CGAffineTransform(translationX: CGFloat(horizontal), y: 0)
                                weakSelf?.movableChesses = (weakSelf?.chessModel.rightMovableChesses)!
                            default:
                                break
                            }
                            weakSelf?.gameBoard.moveRealChesses(transform: (weakSelf?.transform)!, movableChesses: (weakSelf?.movableChesses)!, finished: true)
                            //                    self.sync()
                            //                    self.gameBoard.moveChessesToOrigin(animated: false)
                        })
                    }
                } else {
                    weakSelf?.gameBoard.moveChessesToOrigin(animated: true)
                }
            }
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gameBoard.setRealChess()
        sync()
    }
    
    func moveChesses() { //point:CGPoint
        
        let panGesture = gameBoard.gestureRecognizers?[0] as! UIPanGestureRecognizer
        
        swipeDirection = determineSwipeDirection(translation: panGesture.translation(in: gameBoard))
        let point = panGesture.translation(in: gameBoard)
        
        let chessFrame = gameBoard.chesses[0][0].frame
        
        
        let padding = 10.0
        let horizontal = Double(chessFrame.size.width) + padding
        let vertical = Double(chessFrame.size.height) + padding
        switch self.swipeDirection {
        case .Up:
            currentTranslationPercent = Double(max(point.y,CGFloat(-vertical))) / vertical
            guard currentTranslationPercent < 0 else {
                return
            }
            transform = CGAffineTransform(translationX: 0, y: min(0,max(point.y,CGFloat(-vertical))))
            movableChesses = chessModel.upMovableChesses
        case .Down:
            currentTranslationPercent = Double(max(point.y,CGFloat(-vertical))) / vertical
            guard currentTranslationPercent > 0 else {
                return
            }
            transform = CGAffineTransform(translationX: 0, y: max(0,min(point.y,CGFloat(vertical))))
            movableChesses = chessModel.downMovableChesses
        case .Left:
            currentTranslationPercent = Double(max(point.x,CGFloat(-horizontal))) / horizontal
            guard currentTranslationPercent < 0 else {
                return
            }
            transform = CGAffineTransform(translationX: min(0,max(point.x,CGFloat(-horizontal))), y: 0)
            movableChesses = chessModel.leftMovableChesses
        case .Right:
            currentTranslationPercent = Double(max(0,max(point.x,CGFloat(-horizontal)))) / horizontal
            guard currentTranslationPercent > 0 else {
                return
            }
            transform = CGAffineTransform(translationX: min(point.x,CGFloat(horizontal)), y: 0)
            movableChesses = chessModel.rightMovableChesses
        default:
            return
        }
        print(currentTranslationPercent)
        gameBoard.moveRealChesses(transform: transform, movableChesses: movableChesses, finished: false)
        
    }
    
    func sync() {
        for i in 0...3 {
            for j in 0...3 {
                gameBoard.chesses[i][j].setNumber(number: chessModel.board[i][j],added: plusChesses[i][j],direction: swipeDirection)
            }
        }
        chessModel.resetAdded()
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
