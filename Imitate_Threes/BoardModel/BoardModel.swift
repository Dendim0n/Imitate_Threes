//
//  BoardModel.swift
//  Imitate_Threes
//
//  Created by 任岐鸣 on 2016/10/10.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit

class BoardModel: NSObject {
    
    typealias finishClosure = (Void) -> Void
    var doFinish:finishClosure?
    var doStart:finishClosure?
    
    enum direction {
        case Up
        case Down
        case Left
        case Right
        case None
    }
    
    var board = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
    
    var movedLine = Array<Int>()
    var movedCol = Array<Int>()
    var addedLine = Array<Int>()
    var addedCol = Array<Int>()
    
    var moveDirection:direction = .None
    
    func initBoard() {
        
        for _ in 1...6 {
            let line = Int(arc4random() % 4)
            let row = Int(arc4random() % 4)
            if board[line][row] == 0 {
                board[line][row] = arc4random() % 2 == 0 ? 1 : 2
            }
        }
        //        board = [[1,2,1,2],[2,1,2,1],[0,0,0,0],[0,0,0,0]]
    }
    
    func move(direction:direction) {
        if doStart != nil {
            doStart!()
        }
        switch direction {
        case .Down:
            moveDown()
        case .Left:
            moveLeft()
        case .Right:
            moveRight()
        case .Up:
            moveUp()
        default:
            break;
        }
        moveDirection = direction
        if addChess() {
            print("chess add")
        } else {
            print("cant add")
        }
        movedCol = []
        movedLine = []
        addedLine = []
        addedCol = []
        if (doFinish != nil){
            doFinish!()
        }
    }
    
    func moveUp() {
        for col in 0...3 {
            var added = false
            for line in 0...2 {
                if !added {
                    if canAdd(a: board[line][col], b: board[line+1][col]) {
                        board[line][col] += board[line+1][col]
                        board[line+1][col] = 0
                        added = true
                        if !addedCol.contains(col) {
                            addedCol.append(col)
                        }
                    }
                }
                if board[line][col] == 0 {
                    board[line][col] = board[line+1][col]
                    board[line+1][col] = 0
                    if !movedCol.contains(col) {
                        movedCol.append(col)
                    }
                }
            }
        }
    }
    
    func moveDown() {
        for col in 0...3 {
            var added = false
            for line in 0...2 {
                let actualLine = 3-line
                if !added {
                    if canAdd(a: board[actualLine][col], b: board[actualLine-1][col]) {
                        board[actualLine][col] += board[actualLine-1][col]
                        board[actualLine-1][col] = 0
                        added = true
                        if !addedCol.contains(col) {
                            addedCol.append(col)
                        }
                    }
                }
                if board[actualLine][col] == 0 {
                    board[actualLine][col] = board[actualLine-1][col]
                    board[actualLine-1][col] = 0
                    if !movedCol.contains(col) {
                        movedCol.append(col)
                    }
                }
            }
        }
    }
    
    func moveLeft() {
        for line in 0...3 {
            var added = false
            for col in 0...2 {
                if !added {
                    if canAdd(a: board[line][col], b: board[line][col+1]) {
                        board[line][col] += board[line][col+1]
                        board[line][col+1] = 0
                        added = true
                        if !addedLine.contains(line) {
                            addedLine.append(line)
                        }
                    }
                }
                if board[line][col] == 0 {
                    board[line][col] = board[line][col+1]
                    board[line][col+1] = 0
                    if !movedLine.contains(line) {
                        movedLine.append(line)
                    }
                }
            }
        }
    }
    
    func moveRight() {
        for line in 0...3 {
            var added = false
            for col in 0...2 {
                let actualCol = 3-col
                if !added {
                    if canAdd(a: board[line][actualCol], b: board[line][actualCol-1]) {
                        board[line][actualCol] += board[line][actualCol-1]
                        board[line][actualCol-1] = 0
                        added = true
                        if !addedLine.contains(line) {
                            addedLine.append(line)
                        }
                    }
                }
                if board[line][actualCol] == 0 {
                    board[line][actualCol] = board[line][actualCol-1]
                    board[line][actualCol-1] = 0
                    if !movedLine.contains(line) {
                        movedLine.append(line)
                    }
                }
            }
        }
    }
    
    func canAdd(a:Int,b:Int) -> Bool {
        if (a == 1 && b == 2) || (a == 2 && b == 1) {
            print("a:\(a),b:\(b),=\(a+b)")
            return true
        } else if a != 1 && a != 2 && b != 2 && b != 1 && a == b {
            print("a:\(a),b:\(b),=\(a+b)")
            return true
        } else {
            print("a:\(a),b:\(b),CANT")
            return false
        }
    }
    
    func addChess() -> Bool {
        if hasSpace() {
            
            var location = 0
            switch moveDirection {
            case .Left,.Up:
                location = 3
            case .Right,.Down:
                location = 0
            case .None:
                return false
            }
            
            if !addedLine.isEmpty {
                if addedLine.count == 1 {
                    newChess(line: addedLine[0], col: location)
                } else {
                    let rnd = Int(arc4random() % UInt32(addedLine.count - 1))
                    newChess(line: addedLine[rnd], col: location)
                }
                return true
            } else if !addedCol.isEmpty {
                if addedCol.count == 1 {
                    newChess(line: location, col: addedCol[0])
                } else {
                    let rnd = Int(arc4random() % UInt32(addedCol.count - 1))
                    newChess(line: location, col: rnd)
                }
                return true
            } else if !movedLine.isEmpty {
                if movedLine.count == 1 {
                    newChess(line: movedLine[0], col: location)
                } else {
                    let rnd = Int(arc4random() % UInt32(movedLine.count - 1))
                    newChess(line: movedLine[rnd], col: location)
                }
                return true
            } else if !movedCol.isEmpty {
                if movedCol.count == 1 {
                    newChess(line: location, col: movedCol[0])
                } else {
                    let rnd = Int(arc4random() % UInt32(movedCol.count - 1))
                    newChess(line: location, col: rnd)
                }
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    func newChess(line:Int,col:Int) {
        let arr = [1,2,3,6]
//        return arr[Int(arc4random() % UInt32(4))]
        if board[line][col] == 0 {
            board[line][col] = arr[Int(arc4random() % UInt32(4))]
        }
    }
    
    func hasSpace() -> Bool {
        for line in board {
            for chess in line {
                if chess == 0 {
                    return true
                }
            }
        }
        return false
    }
    
    func printBoard () {
        for sub in board {
            print(sub)
        }
    }
    
    func initClosure(startClosure:finishClosure?,finishClosure:finishClosure?){
        doFinish = finishClosure
        doStart = startClosure
    }
}
