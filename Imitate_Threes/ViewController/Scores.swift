//
//  GameViewController.swift
//  Imitate_Threes
//
//  Created by 任岐鸣 on 2016/10/10.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit

class Scores: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    var scores = Array<ScoreModel>()
    
    var collectionView:UICollectionView?
    var collectionLayout:UICollectionViewFlowLayout {
        get {
            let layout = UICollectionViewFlowLayout.init()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 20
            layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
            layout.itemSize = CGSize.init(width: view.frame.size.width * 0.7, height: view.frame.size.height * 0.8)
            return layout
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadScores()
        setView()
        // Do any additional setup after loading the view.
        collectionView?.scrollToItem(at: IndexPath.init(row: 1, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setView() {
        view.backgroundColor = .white
        
        let btnBack = UIButton.init(x: 0, y: 0, w: 0, h: 0, target: self, action: #selector(back))
        btnBack.layer.cornerRadius = 3
        btnBack.setTitle("Back", for: .normal)
        btnBack.setTitleColor(.white, for: .normal)
        btnBack.backgroundColor = .darkGray
        view.addSubview(btnBack)
        
        collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: collectionLayout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(ScoreCell.self, forCellWithReuseIdentifier: "scoreCell")
        collectionView?.register(SettingCell.self, forCellWithReuseIdentifier: "settingCell")
        collectionView?.register(ThanksCell.self, forCellWithReuseIdentifier: "thanksCell")
        view.addSubview(collectionView!)
        collectionView?.backgroundColor = .clear
        collectionView?.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-50)
//            make.height.equalTo((collectionView?.snp.width)!).multipliedBy(1.6)
            make.top.equalTo(btnBack.snp.bottom).offset(50)
        }
        
        btnBack.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(40)
            make.top.equalToSuperview().offset(40)
            make.height.equalTo(30)
            make.width.equalTo(50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        let num = [scores.count,2]
        let num = [2,2]
        return num[section]
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var identifier = "scoreCell"
        var color = UIColor.black
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                identifier = "settingCell"
                color = .red
            case 1:
                identifier = "thanksCell"
                color = .yellow
            default:
                break
            }
        } else {
            identifier = "scoreCell"
            color = .gray
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        cell.backgroundColor = color
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func loadScores() {
        
    }
    
    func back() {
        dismissVC(completion: nil)
    }

}
