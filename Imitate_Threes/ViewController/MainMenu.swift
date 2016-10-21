//
//  GameStartViewController.swift
//  Imitate_Threes
//
//  Created by 任岐鸣 on 2016/10/10.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit

class MainMenu: UIViewController {
    
    var centerBoard = BoardView.init()
    
    var firstInit = true

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        view.backgroundColor = .white
        view.addSubview(centerBoard)
        
        
        let btnMenu = ThreesButton.init(buttonColor: .gray)
        btnMenu.addTarget(self, action: #selector(goToMenu), for: UIControlEvents.touchUpInside)
        btnMenu.layer.cornerRadius = 3
//        btnMenu.setTitle("Menu", for: .normal)
        btnMenu.lblTitle.text = "Menu"
        btnMenu.setTitleColor(.white, for: .normal)
//        btnMenu.backgroundColor = .darkGray
        view.addSubview(btnMenu)
        
        let btnHelp = ThreesButton.init(buttonColor: UIColor.gray)
        btnHelp.addTarget(self, action: #selector(goToMenu), for: UIControlEvents.touchUpInside)
        btnHelp.layer.cornerRadius = 3
//        btnHelp.backgroundColor = .darkGray
//        btnHelp.setTitle("Help", for: .normal)
        btnHelp.lblTitle.text = "Help"
        btnHelp.setTitleColor(.white, for: .normal)
        view.addSubview(btnHelp)
        
        let letterStack = UIStackView.init()
        letterStack.alignment = .center
        letterStack.distribution = .fillEqually
        for letter in "THREES".characters {
            let label = UILabel.init()
            label.text = "\(letter)"
//            Menlo Bold 30.0
            label.font = UIFont.Font(.Menlo, type: .Bold, size: 30)
            if letter.toString == "T" {
                label.textColor = UIColor.init(colorLiteralRed: 86/255.0, green: 192/255.0, blue: 254/255.0, alpha: 1)
            } else if letter.toString == "H" {
                label.textColor = UIColor.init(colorLiteralRed: 252/255.0, green: 76/255.0, blue: 109/255.0, alpha: 1)
            } else {
                label.textColor = .darkGray
            }
            label.textAlignment = .center
            letterStack.addArrangedSubview(label)
        }
        view.addSubview(letterStack)
        
        
        
        btnMenu.snp.makeConstraints { (make) in
            make.left.equalTo(centerBoard)
            make.top.equalToSuperview().offset(40)
            make.height.equalTo(40)
            make.width.equalTo(65)
        }
        
        btnHelp.snp.makeConstraints { (make) in
            make.right.equalTo(centerBoard)
            make.top.equalToSuperview().offset(40)
            make.height.equalTo(40)
            make.width.equalTo(65)
        }
        
        letterStack.snp.makeConstraints { (make) in
            make.left.equalTo(btnMenu.snp.right).offset(5)
            make.right.equalTo(btnHelp.snp.left).offset(-5)
            make.top.equalTo(btnMenu)
            make.bottom.equalTo(btnMenu)
        }
        
        let btnPlay = ThreesButton.init(buttonColor: UIColor.init(r: 255, g: 102, b: 128))
        btnPlay.addTarget(self, action: #selector(playGame), for: UIControlEvents.touchUpInside)
//        btnPlay.backgroundColor = .darkGray
        btnPlay.layer.cornerRadius = 3
//        btnPlay.setTitle("Play", for: .normal)
        btnPlay.lblTitle.text = "Play"
        btnPlay.setTitleColor(.white, for: .normal)
        view.addSubview(btnPlay)
        btnPlay.snp.makeConstraints { (make) in
            make.left.equalTo(centerBoard)
            make.right.equalTo(centerBoard)
            make.bottom.equalToSuperview().offset(-40)
            make.height.equalTo(50)
        }
        
        centerBoard.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.top.equalTo(btnMenu.snp.bottom).offset(45)
            make.bottom.equalTo(btnPlay.snp.top).offset(-45)
            //            make.height.equalTo(view.snp.width).multipliedBy(1.6)
        }
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if firstInit {
            centerBoard.setRealChess()
            firstInit = false
        }
        let arr = [[1,2,3,6],[12,24,48,96],[192,384,768,0],[0,0,0,0]]
        let delay = 0.1
        
        for i in 0...3 {
            for j in 0...3 {
                let chess = centerBoard.chesses[i][j]
//                chess.removeFromSuperview()
//                centerBoard.addSubview(chess)
                chess.transform = CGAffineTransform.init(scaleX: 0, y: 0)
                chess.setNumber(number: arr[i][j],added: false,direction: .none)
                UIView.animate(withDuration: 0.4, delay: delay*Double(i+j), usingSpringWithDamping: 0.7, initialSpringVelocity: 5, options: UIViewAnimationOptions.allowUserInteraction, animations: {
                    chess.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                    }, completion: nil)
            }
        }
        
    }
    
    func goToMenu() {
        let vc = Scores.init()
        vc.view.backgroundColor = .white
        self.presentVC(vc)
    }
    func goToHelp() {
//        let vc = .init()
//        self.pushVC(vc)
    }
    func playGame() {
        let vc = GamePlay.init()
        vc.view.backgroundColor = .white
        presentVC(vc)
    }
}
