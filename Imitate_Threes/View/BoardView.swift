//
//  BoardView.swift
//  Imitate_Threes
//
//  Created by 任岐鸣 on 2016/10/10.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit

class BoardView: UIView {
    
    let spacing = 10
    
    var chesses = [[ChessView.init(),ChessView.init(),ChessView.init(),ChessView.init()],[ChessView.init(),ChessView.init(),ChessView.init(),ChessView.init()],[ChessView.init(),ChessView.init(),ChessView.init(),ChessView.init()],[ChessView.init(),ChessView.init(),ChessView.init(),ChessView.init()]]
    
//    [[UIView.init(),UIView.init(),UIView.init(),UIView.init()],[UIView.init(),UIView.init(),UIView.init(),UIView.init()],[UIView.init(),UIView.init(),UIView.init(),UIView.init()],[UIView.init(),UIView.init(),UIView.init(),UIView.init()]]
    
    var hiddenChesses = [[ChessView.init(),ChessView.init(),ChessView.init(),ChessView.init()],[ChessView.init(),ChessView.init(),ChessView.init(),ChessView.init()],[ChessView.init(),ChessView.init(),ChessView.init(),ChessView.init()],[ChessView.init(),ChessView.init(),ChessView.init(),ChessView.init()]]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        for i in 0...3 {
            for j in 0...3 {
                hiddenChesses[i][j].backgroundColor = UIColor.brown
            }
        }
        let mainStackView = UIStackView.init()
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
                chesses[i][j].backgroundColor = UIColor.black
                chesses[i][j].alpha = 0.5
                addSubview(chesses[i][j])
                
                chesses[i][j].snp.makeConstraints { (make) in
                    make.edges.equalTo(hiddenChesses[i][j])
                }

            }
        }
    }
    
}
