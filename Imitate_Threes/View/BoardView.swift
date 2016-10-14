//
//  BoardView.swift
//  Imitate_Threes
//
//  Created by 任岐鸣 on 2016/10/10.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit

class BoardView: UIView {
    
    typealias closure = (Void) -> Void
    
    var finishedClosure:closure?
    
    let spacing = 10
    
    var chesses = [[ChessView.init(),ChessView.init(),ChessView.init(),ChessView.init()],[ChessView.init(),ChessView.init(),ChessView.init(),ChessView.init()],[ChessView.init(),ChessView.init(),ChessView.init(),ChessView.init()],[ChessView.init(),ChessView.init(),ChessView.init(),ChessView.init()]]
    
    var hiddenChesses = [[ChessView.init(),ChessView.init(),ChessView.init(),ChessView.init()],[ChessView.init(),ChessView.init(),ChessView.init(),ChessView.init()],[ChessView.init(),ChessView.init(),ChessView.init(),ChessView.init()],[ChessView.init(),ChessView.init(),ChessView.init(),ChessView.init()]]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        for i in 0...3 {
            for j in 0...3 {
                hiddenChesses[i][j].backgroundColor = UIColor.white
            }
        }
        let mainStackView = UIStackView.init()
        self.backgroundColor = UIColor.lightGray
        addSubview(mainStackView)
        mainStackView.alignment = UIStackViewAlignment.fill
        mainStackView.axis = UILayoutConstraintAxis.vertical
        mainStackView.spacing = CGFloat(spacing)
        mainStackView.distribution = UIStackViewDistribution.fillEqually
        mainStackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        for i in 0...3 {
            let lineStackView = UIStackView.init()
            lineStackView.alignment = UIStackViewAlignment.fill
            lineStackView.axis = UILayoutConstraintAxis.horizontal
            lineStackView.spacing = CGFloat(spacing)
            lineStackView.distribution = UIStackViewDistribution.fillEqually
            for j in 0...3 {
                lineStackView.addArrangedSubview(hiddenChesses[i][j])
            }
            mainStackView.addArrangedSubview(lineStackView)
        }
    }
    
    func setRealChess() {
        for i in 0...3 {
            for j in 0...3 {
                chesses[i][j] = ChessView.init(frame: hiddenChesses[i][j].frame)
                print(hiddenChesses[i][j].frame)
                //                chesses[i][j].backgroundColor = UIColor.black
                //                chesses[i][j].alpha = 0.5
                addSubview(chesses[i][j])
                chesses[i][j].line = i
                chesses[i][j].col = j
                chesses[i][j].snp.makeConstraints { (make) in
                    make.edges.equalTo(hiddenChesses[i][j])
                }
                
            }
        }
    }
    
    func moveRealChesses(transform:CGAffineTransform,movableChesses:Array<Array<Bool>>,finished:Bool){
        if !finished {
            for line in 0...3 {
                for col in 0...3 {
                    if movableChesses[line][col] && self.chesses[line][col].chessNum != 0 {
                        chesses[line][col].transform = transform
                    }
                }
            }
        } else {
            UIView.beginAnimations("finishAnimation", context: nil)
            UIView.setAnimationDelegate(self)
            UIView.setAnimationDelay(0)
            UIView.setAnimationDuration(0.2)
            for line in 0...3 {
                for col in 0...3 {
                    if movableChesses[line][col] && self.chesses[line][col].chessNum != 0 {
                        self.chesses[line][col].transform = transform
                    }
                }
            }
            UIView.setAnimationDidStop(#selector(animStop))
            UIView.commitAnimations()
        }
    }
    
    func animStop() {
        print("animStopped")
        self.moveChessesToOrigin(animated: false)
        self.finishedClosure?()
    }
    
    func moveChessesToOrigin(animated:Bool) {
        for line in 0...3 {
            for col in 0...3 {
                if animated {
                    UIView.animate(withDuration: 0.3, animations: {
                        self.chesses[line][col].transform = CGAffineTransform.init(translationX: 0, y: 0)
                    })
                } else {
                    chesses[line][col].transform = CGAffineTransform.init(translationX: 0, y: 0)
                }
                
            }
        }
    }
}
