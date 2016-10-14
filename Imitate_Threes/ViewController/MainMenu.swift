//
//  GameStartViewController.swift
//  Imitate_Threes
//
//  Created by 任岐鸣 on 2016/10/10.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit

class MainMenu: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUI() {
        let centerBoard = UIView.init()
        view.addSubview(centerBoard)
        centerBoard.backgroundColor = .darkGray
        centerBoard.layer.cornerRadius = 5
        centerBoard.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(view.snp.width).multipliedBy(0.8)
        }
        
        let btnMenu = UIButton.init(x: 0, y: 0, w: 0, h: 0, target: self, action: #selector(goToMenu))
        btnMenu.layer.cornerRadius = 3
        btnMenu.setTitle("Menu", for: .normal)
        btnMenu.setTitleColor(.white, for: .normal)
        btnMenu.backgroundColor = .darkGray
        view.addSubview(btnMenu)
        
        let btnHelp = UIButton.init(x: 0, y: 0, w: 0, h: 0, target: self, action: #selector(goToHelp))
        btnHelp.layer.cornerRadius = 3
        btnHelp.backgroundColor = .darkGray
        btnHelp.setTitle("Help", for: .normal)
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
            make.height.equalTo(30)
            make.width.equalTo(50)
        }
        
        btnHelp.snp.makeConstraints { (make) in
            make.right.equalTo(centerBoard)
            make.top.equalToSuperview().offset(40)
            make.height.equalTo(30)
            make.width.equalTo(50)
        }
        
        letterStack.snp.makeConstraints { (make) in
            make.left.equalTo(btnMenu.snp.right).offset(20)
            make.right.equalTo(btnHelp.snp.left).offset(-20)
            make.top.equalTo(btnMenu)
            make.bottom.equalTo(btnMenu)
        }
        
        let btnPlay = UIButton.init(x: 0, y: 0, w: 0, h: 0, target: self, action: #selector(playGame))
        btnPlay.backgroundColor = .darkGray
        btnPlay.layer.cornerRadius = 3
        btnPlay.setTitle("Play", for: .normal)
        btnPlay.setTitleColor(.white, for: .normal)
        view.addSubview(btnPlay)
        btnPlay.snp.makeConstraints { (make) in
            make.left.equalTo(centerBoard)
            make.right.equalTo(centerBoard)
            make.bottom.equalToSuperview().offset(-40)
            make.height.equalTo(40)
        }
        
    }
    
    func goToMenu() {
        
    }
    func goToHelp() {
        
    }
    func playGame() {
        
    }
}