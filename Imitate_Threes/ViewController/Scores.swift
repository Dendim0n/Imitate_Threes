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
    
    var btnBack = UIButton.init()
    
    var titleView = TransitionView.init()
    
    var collectionView:UICollectionView?
    var collectionLayout:UICollectionViewFlowLayout {
        get {
            let layout = UICollectionViewFlowLayout.init()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 20
            layout.sectionInset = UIEdgeInsetsMake(0, view.frame.size.width * 0.15, 0, view.frame.size.width * 0.15)
            layout.itemSize = CGSize.init(width: view.frame.size.width * 0.7, height: view.frame.size.height * 0.6)
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
        btnBack = UIButton.init(x: 0, y: 0, w: 0, h: 0, target: self, action: #selector(back))
        btnBack.layer.cornerRadius = 3
        btnBack.setTitle("Back", for: .normal)
        btnBack.setTitleColor(.white, for: .normal)
        btnBack.backgroundColor = .darkGray
        
        
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
            make.left.equalTo(view).offset(40)
            make.top.equalTo(view).offset(40)
            make.height.equalTo(30)
            make.width.equalTo(50)
        }
        titleView.snp.makeConstraints { (make) in
            make.top.equalTo(btnBack)
            make.bottom.equalTo(btnBack)
            make.right.equalToSuperview().offset(-40)
            make.width.equalTo(180)
        }
        
//        let testLabel = UILabel.init()
//        testLabel.text = "test"
//        testLabel.backgroundColor = .gray
//        titleView.setView(testLabel)
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
            let testLbl = UILabel.init()
            testLbl.text = "test2"
            testLbl.textAlignment = .center
            titleView.transitionToView(testLbl, from: .top)
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
        cell.setCornerRadius(radius: 5)
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
