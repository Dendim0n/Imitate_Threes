//
//  GameViewController.swift
//  Imitate_Threes
//
//  Created by 任岐鸣 on 2016/10/10.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit
import CoreData

class Scores: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    var scores = [Array<Array<Int>>]()
    
    var btnBack = ThreesButton.init()
    
    var titleView = TransitionView.init()
    
    var collectionView:UICollectionView?
    lazy var collectionLayout:scoreLayout = {
        
            let layout = scoreLayout.init()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 20
            layout.sectionInset = UIEdgeInsetsMake(0, self.view.frame.size.width * 0.15, 0, self.view.frame.size.width * 0.15)
            layout.itemSize = CGSize.init(width: self.view.frame.size.width * 0.7, height: self.view.frame.size.height * 0.6)
            return layout
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadScores()
        setView()
    }
    
    func setView() {
        view.backgroundColor = .white
        btnBack = ThreesButton.init(buttonColor: .gray)
        btnBack.addTarget(self, action: #selector(back), for: .touchUpInside)
        btnBack.layer.cornerRadius = 3
        btnBack.lblTitle.text = "Back"
        btnBack.setTitleColor(.white, for: .normal)
        
        collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: collectionLayout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(ScoreCell.self, forCellWithReuseIdentifier: "scoreCell")
        collectionView?.register(SettingCell.self, forCellWithReuseIdentifier: "settingCell")
        collectionView?.register(ThanksCell.self, forCellWithReuseIdentifier: "thanksCell")
        view.addSubview(collectionView!)
        view.addSubview(titleView)
        view.addSubview(btnBack)
        collectionView?.backgroundColor = .clear
        
        collectionView?.snp.makeConstraints { (make) in
            //            make.edges.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-70)
            make.top.equalToSuperview().offset(100)
        }
        btnBack.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.top.equalToSuperview().offset(40)
            make.height.equalTo(40)
            make.width.equalTo(65)
        }
        titleView.snp.makeConstraints { (make) in
            make.top.equalTo(btnBack)
            make.bottom.equalTo(btnBack)
            make.right.equalToSuperview().offset(-40)
            make.width.equalTo(180)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let num = [scores.count,2]
        return num[section]
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var identifier = "scoreCell"
        if indexPath.section == 1 {
            let testLbl = UILabel.init()
            testLbl.text = indexPath.row == 0 ? "Settings" : "Thanks"
            testLbl.textAlignment = .center
            titleView.transitionToView(testLbl, from: .top)
            switch indexPath.row {
            case 0:
                identifier = "settingCell"
            case 1:
                identifier = "thanksCell"
            default:
                break
            }
        } else {
            
            identifier = "scoreCell"
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        if identifier == "scoreCell" {
            (cell as! ScoreCell).board = scores[indexPath.row]
            (cell as! ScoreCell).commonInit()

            let testLbl = UILabel.init()
            testLbl.text = "Score:\(getScore(board: scores[indexPath.row]))"
            testLbl.textAlignment = .center
            titleView.transitionToView(testLbl, from: .top)
        }
        cell.origin.y = 28.5
        cell.setCornerRadius(radius: 5)
        print(collectionView.frame.height / 5)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func loadScores() {
        let scoresArr:[Score] = CoreDataTools.sharedInstance.search(entityName: "Score", sort: nil, ascending: true, predicate: nil)!
        var resultOfBoards = [Array<Array<Int>>]()
        for result in scoresArr {
            resultOfBoards.append(result.board as! Array<Array<Int>>)
        }
        scores = resultOfBoards
        collectionView?.reloadData()
    }
    
    func back() {
        dismissVC(completion: nil)
    }
    
    func getScore(board:Array<Array<Int>>) -> Int {
        var scoreDic:Dictionary<Double,Double> = [:]
        for k in 1...20 {
            scoreDic[Double(3)*pow(2.0, Double(k-1))] = pow(3.0, Double(k))
        }
        var score:Double = 0.0
        for i in 0...3 {
            for j in 0...3 {
                let chessPoint = Double(board[i][j])
                if chessPoint >= 3 {
                    score += scoreDic[chessPoint]!
                }
            }
        }
        return Int(score)
    }
    
}
