//
//  ScoreModel.swift
//  Imitate_Threes
//
//  Created by 任岐鸣 on 16/10/14.
//  Copyright © 2016年 Ned. All rights reserved.
//

import Foundation

class ScoreModel {
    var chessArray = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
    var score:Int {
        get {
            return getScore()
        }
    }
    
    func getScore() -> Int {
        var scoreDic:Dictionary<Double,Double> = [:]
        for k in 1...20 {
            scoreDic[Double(3)*pow(2.0, Double(k-1))] = pow(3.0, Double(k))
        }
        var score:Double = 0.0
        for i in 0...3 {
            for j in 0...3 {
                let chessPoint = Double(chessArray[i][j])
                if chessPoint >= 3 {
                    score += scoreDic[chessPoint]!
                    print("Point:\(scoreDic[chessPoint])")
                }
            }
        }
        return Int(score)
    }
}
