//
//  JustForTestVC.swift
//  Imitate_Threes
//
//  Created by 任岐鸣 on 2016/10/10.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit
import CoreData

class GamePlay: UIViewController {
    
    var displayLink = CADisplayLink()
    var swipe = UISwipeGestureRecognizer.init()
    var chessModel = BoardModel()
    var gameBoard = BoardView.init()
    var swipeDirection = BoardModel.direction.none
    var currentPoint = CGPoint.init(x: 0, y: 0)
    var currentTranslationPercent = 0.0
    var movableChesses = Array<Array<Bool>>()
    var transform = CGAffineTransform()
    
    var plusChesses = Array(repeatElement(Array(repeatElement(false, count: 4)), count: 4))
    
    var btnMenu = ThreesButton.init(buttonColor: UIColor.gray)
    var btnStatus = ThreesButton.init(buttonColor: UIColor.gray)
    var nextChess = UIStackView.init()
    var nextChessBG = UIView.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        initBoard()
    }
    
    func setUI() {
        view.backgroundColor = .white
        //        btnMenu.setTitle("Menu", for: UIControlState.normal)
        //        btnStatus.setTitle("Stat", for: UIControlState.normal)
        btnMenu.lblTitle.text = "Back"
        btnStatus.lblTitle.text = "Stat"
        nextChessBG.backgroundColor = UIColor.init(r: 207, g: 230, b: 223, a: 1)
        nextChess.alignment = .fill
        nextChess.distribution = .fillEqually
        nextChess.axis = .horizontal
        nextChess.spacing = 10
        nextChess.backgroundColor = .clear
        
        btnMenu.addTarget(self, action: #selector(back), for: UIControlEvents.touchUpInside)
        btnStatus.addTarget(self, action: #selector(showA), for: UIControlEvents.touchUpInside)
        nextChessBG.setCornerRadius(radius: 8)
        btnMenu.layer.cornerRadius = 3
        btnStatus.layer.cornerRadius = 3
        view.addSubview(btnMenu)
        view.addSubview(btnStatus)
        view.addSubview(nextChessBG)
        view.addSubview(nextChess)
        view.addSubview(gameBoard)
        
        gameBoard.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.top.equalTo(nextChessBG.snp.bottom).offset(50)
            make.bottom.equalToSuperview().offset(-100)
        }
        
        btnMenu.snp.makeConstraints { (make) in
            make.left.equalTo(gameBoard)
            make.top.equalToSuperview().offset(40)
            make.height.equalTo(40)
            make.width.equalTo(65)
        }
        
        btnStatus.snp.makeConstraints { (make) in
            make.right.equalTo(gameBoard)
            make.top.equalToSuperview().offset(40)
            make.height.equalTo(40)
            make.width.equalTo(65)
        }
        
        nextChessBG.snp.makeConstraints { (make) in
            make.bottom.equalTo(btnMenu).offset(20)
            make.width.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(-10)
        }
        
        nextChess.snp.makeConstraints { (make) in
            make.bottom.equalTo(nextChessBG).offset(-18)
            make.left.equalTo(btnMenu.snp.right).offset(10)
            make.right.equalTo(btnStatus.snp.left).offset(-10)
            make.top.equalTo(btnMenu).offset(-5)
        }
        
    }
    
    func initBoard() {
        chessModel.initBoard()
        
        weak var weakSelf = self
        gameBoard.finishedClosure = {
            Void in
            weakSelf?.sync()
            weakSelf?.chessModel.addNewChess()
        }
        chessModel.doAdded = {
            Void in
            weakSelf?.sync()
        }
        chessModel.doEvaluated = {
            Void in
            weakSelf?.showNextChesses()
        }
        chessModel.doMoved = {
            array in
            weakSelf?.plusChesses = array
        }
        chessModel.doLosed = {
            score in
            let tryAgainClosure = {
                self.tryAgain()
            }
            let mainMenuClosure = {
                self.back()
            }
            weakSelf?.showAlert(title: "You Lose!", detailText:"Score:\(score)" , buttonTitles: ["Try Again","Main Menu"],buttonClosures: [tryAgainClosure,mainMenuClosure])
            weakSelf?.saveScore(score)
        }
        gameBoard.addPanGesture { (gesture) in
            if (gesture.state == UIGestureRecognizerState.began) {
                weakSelf?.swipeDirection = .none
                self.displayLink = CADisplayLink.init(target: weakSelf!, selector: #selector(self.moveChesses))
                weakSelf?.displayLink.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
            } else if (gesture.state == UIGestureRecognizerState.ended) {
                print("end")
                weakSelf?.displayLink.remove(from: RunLoop.current, forMode: RunLoopMode.commonModes)
                if (weakSelf!.currentTranslationPercent > 0.6 && (weakSelf!.swipeDirection == .down || weakSelf!.swipeDirection == .right)) || (weakSelf!.currentTranslationPercent < -0.6 && (weakSelf!.swipeDirection == .up || weakSelf!.swipeDirection == .left))  {
                    
                    DispatchQueue.global().async {
                        weakSelf?.chessModel.move(direction: (weakSelf?.swipeDirection)!)
                        DispatchQueue.main.async(execute: {
                            
                            let chessFrame = weakSelf?.gameBoard.chesses[0][0].frame
                            let padding = 10.0
                            let horizontal = Double((chessFrame?.size.width)!) + padding
                            let vertical = Double((chessFrame?.size.height)!) + padding
                            
                            switch weakSelf!.swipeDirection {
                            case .up:
                                weakSelf?.transform = CGAffineTransform(translationX: 0, y: CGFloat(-vertical))
                                weakSelf?.movableChesses = weakSelf!.chessModel.upMovableChesses
                            case .down:
                                weakSelf?.transform = CGAffineTransform(translationX: 0, y: CGFloat(vertical))
                                weakSelf?.movableChesses = weakSelf!.chessModel.downMovableChesses
                            case .left:
                                weakSelf?.transform = CGAffineTransform(translationX: CGFloat(-horizontal), y: 0)
                                weakSelf?.movableChesses = weakSelf!.chessModel.leftMovableChesses
                            case .right:
                                weakSelf?.transform = CGAffineTransform(translationX: CGFloat(horizontal), y: 0)
                                weakSelf?.movableChesses = weakSelf!.chessModel.rightMovableChesses
                            default:
                                break
                            }
                            var boardMovable = false
                            for i in 0...3 {
                                for j in 0...3 {
                                    if weakSelf!.movableChesses[i][j] == true {
                                        boardMovable = true
                                        break
                                    }
                                }
                            }
                            if boardMovable {
                                weakSelf!.gameBoard.moveRealChesses(transform: weakSelf!.transform, movableChesses: weakSelf!.movableChesses, finished: true)
                            }
                            weakSelf!.gameBoard.moveChessesToOrigin(animated: false)
                        })
                    }
                } else {
                    weakSelf!.gameBoard.moveChessesToOrigin(animated: true)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gameBoard.setRealChess()
        sync()
    }
    
    func moveChesses() {
        
        let panGesture = gameBoard.gestureRecognizers?[0] as! UIPanGestureRecognizer
        swipeDirection = determineSwipeDirection(translation: panGesture.translation(in: gameBoard))
        let point = panGesture.translation(in: gameBoard)
        let chessFrame = gameBoard.chesses[0][0].frame
        let padding = 10.0
        let horizontal = Double(chessFrame.size.width) + padding
        let vertical = Double(chessFrame.size.height) + padding
        
        switch self.swipeDirection {
        case .up:
            currentTranslationPercent = Double(max(point.y,CGFloat(-vertical))) / vertical
            guard currentTranslationPercent < 0 else {
                return
            }
            transform = CGAffineTransform(translationX: 0, y: min(0,max(point.y,CGFloat(-vertical))))
            movableChesses = chessModel.upMovableChesses
        case .down:
            currentTranslationPercent = Double(max(point.y,CGFloat(-vertical))) / vertical
            guard currentTranslationPercent > 0 else {
                return
            }
            transform = CGAffineTransform(translationX: 0, y: max(0,min(point.y,CGFloat(vertical))))
            movableChesses = chessModel.downMovableChesses
        case .left:
            currentTranslationPercent = Double(max(point.x,CGFloat(-horizontal))) / horizontal
            guard currentTranslationPercent < 0 else {
                return
            }
            transform = CGAffineTransform(translationX: min(0,max(point.x,CGFloat(-horizontal))), y: 0)
            movableChesses = chessModel.leftMovableChesses
        case .right:
            currentTranslationPercent = Double(max(0,max(point.x,CGFloat(-horizontal)))) / horizontal
            guard currentTranslationPercent > 0 else {
                return
            }
            transform = CGAffineTransform(translationX: min(point.x,CGFloat(horizontal)), y: 0)
            movableChesses = chessModel.rightMovableChesses
        default:
            return
        }
        gameBoard.moveRealChesses(transform: transform, movableChesses: movableChesses, finished: false)
    }
    
    func showNextChesses() {
        DispatchQueue.main.sync {
            for view in self.nextChess.arrangedSubviews {
                //            nextChess.removeArrangedSubview(view)
                view.removeFromSuperview()
            }
            let chessesNum = self.chessModel.newChesses
            for chessNum in chessesNum {
                let newChess = NextChessView.init(num: chessNum)
                self.nextChess.addArrangedSubview(newChess)
            }
        }
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
            
            if swipeDirection != .none {
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
                        return .right
                    } else {
                        return .left
                    }
                }
            } else if (fabs(translation.y) > CGFloat(gestureMinimumTranslation)) {
                if translation.y > 0.0 {
                    return .down
                } else {
                    return .up
                }
            }
            return swipeDirection
    }
    
    func back() {
        dismissVC(completion: nil)
    }
    
    func tryAgain() {
        
        UIView.animate(withDuration: 0.5, delay: 0.3, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.gameBoard.transform = CGAffineTransform.init(scaleX: 0, y: 0)
        }) { (Bool) in
            self.chessModel.resetBoard()
            self.sync()
        }
        UIView.animate(withDuration: 0.5, delay: 0.8, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.gameBoard.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }) { (Bool) in
                
        }
    }
    
    func saveScore(_ score:Int) {
        
        let s = NSNumber.init(integerLiteral: score)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Score", in: managedContext)
        let score = NSManagedObject.init(entity: entity!, insertInto: managedContext)
        score.setValue(s, forKey: "score")
        score.setValue(chessModel.board, forKey: "board")
        try? managedContext.save()
        
    }
    
    func showA() {
        showAlert(title: "(⊙o⊙)…", detailText: "并没有统计数据。。", buttonTitles: ["Close"], buttonClosures: [])
    }
}
