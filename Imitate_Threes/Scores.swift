//
//  GameViewController.swift
//  Imitate_Threes
//
//  Created by 任岐鸣 on 2016/10/10.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit

class Scores: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    var collectionView:UICollectionView?
    var collectionLayout:UICollectionViewFlowLayout {
        get {
            let layout = UICollectionViewFlowLayout.init()
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize.init(width: view.frame.size.width * 0.7, height: view.frame.size.height * 0.8)
            return layout
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setView() {
        view.backgroundColor = .white
        collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: collectionLayout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.addSubview(collectionView!)
        collectionView?.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .gray
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    

}
