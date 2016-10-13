//
//  BoardModel.swift
//  Imitate_Threes
//
//  Created by 任岐鸣 on 2016/10/10.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit

class BoardModel: NSObject {
    

    typealias finishClosure = (CGPoint) -> Void
    var doAddNewChessClosure:finishClosure?
    
    var leftMovableChesses = Array(repeatElement(Array(repeatElement(false, count: 4)), count: 4))
    var rightMovableChesses = Array(repeatElement(Array(repeatElement(false, count: 4)), count: 4))
    var upMovableChesses = Array(repeatElement(Array(repeatElement(false, count: 4)), count: 4))
    var downMovableChesses = Array(repeatElement(Array(repeatElement(false, count: 4)), count: 4))
    
    var addedPosition = Array(repeatElement(Array(repeatElement(false, count: 4)), count: 4))
    
    enum direction {
        case Up
        case Down
        case Left
        case Right
        case None
    }
    
    enum moveType {
        case Line
        case Col
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
        evaluateBoard()
    }
    
    func move(direction:direction) {

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

        evaluateBoard()
    }
    
    func moveUp() {
        for col in 0...3 {
            var added = false
            for line in 0...2 {
                if !added {
                    if canAdd(a: board[line][col], b: board[line+1][col]) {
                        board[line][col] += board[line+1][col]
                        board[line+1][col] = 0
                        addedPosition[line][col] = true
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
                        addedPosition[actualLine][col] = true
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
                        addedPosition[line][col] = true
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
                        addedPosition[line][actualCol] = true
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
            //            print("a:\(a),b:\(b),=\(a+b)")
            return true
        } else if a != 1 && a != 2 && b != 2 && b != 1 && a == b {
            //            print("a:\(a),b:\(b),=\(a+b)")
            return true
        } else {
            //            print("a:\(a),b:\(b),CANT")
            return false
        }
    }
    
    func canMove(a:Int,b:Int) -> Bool {
        if (a == 1 && b == 2) || (a == 2 && b == 1) {
            //            print("a:\(a),b:\(b),=\(a+b)")
            return true
        } else if (a != 1 && a != 2 && b != 2 && b != 1 && a == b) {
            //            print("a:\(a),b:\(b),=\(a+b)")
            return true
        } else if (a == 0 && b != 0) || (a != 0 && b == 0) {
            //            print("a:\(a),b:\(b),CANT")
            return true
        } else {
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
                    self.doAddNewChessClosure!(CGPoint.init(x: rnd, y: location))
                }
                return true
            } else if !addedCol.isEmpty {
                if addedCol.count == 1 {
                    newChess(line: location, col: addedCol[0])
                } else {
                    let rnd = Int(arc4random() % UInt32(addedCol.count - 1))
                    newChess(line: location, col: rnd)
                    self.doAddNewChessClosure!(CGPoint.init(x: location, y: rnd))
                }
                return true
            } else if !movedLine.isEmpty {
                if movedLine.count == 1 {
                    newChess(line: movedLine[0], col: location)
                } else {
                    let rnd = Int(arc4random() % UInt32(movedLine.count - 1))
                    newChess(line: movedLine[rnd], col: location)
                    self.doAddNewChessClosure!(CGPoint.init(x: rnd, y: location))
                }
                return true
            } else if !movedCol.isEmpty {
                if movedCol.count == 1 {
                    newChess(line: location, col: movedCol[0])
                } else {
                    let rnd = Int(arc4random() % UInt32(movedCol.count - 1))
                    newChess(line: location, col: rnd)
                    self.doAddNewChessClosure!(CGPoint.init(x: location, y: rnd))
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
    
    func evaluateBoard() {
        DispatchQueue.global().async {
            self.leftMovableChesses = self.getMovableChesses(moveDirection: .Left)
            self.rightMovableChesses = self.getMovableChesses(moveDirection: .Right)
            self.upMovableChesses = self.getMovableChesses(moveDirection: .Up)
            self.downMovableChesses = self.getMovableChesses(moveDirection: .Down)
        }
    }
    
    func getMovableChesses(moveDirection:direction) -> Array<Array<Bool>> {
        var movableChesses = Array(repeatElement(Array(repeatElement(false, count: 4)), count: 4))
        
        switch moveDirection {
        case .Up:
            for col in 0...3 {
                let movableCol = colMovable(moveD: .Up,numCol: col)
                for line in 0...3 {
                    movableChesses[line][col] = movableCol[line]
                }
            }
        case .Down:
            for col in 0...3 {
                let movableCol = colMovable(moveD: .Down,numCol: col)
                for line in 0...3 {
                    movableChesses[line][col] = movableCol[line]
                }
            }
        case .Left:
            for line in 0...3 {
                movableChesses[line] = lineMovable(num: line,moveD: .Left)
            }
        case .Right:
            for line in 0...3 {
                movableChesses[line] = lineMovable(num: line,moveD: .Right)
            }
        default:
            break
        }
        print(movableChesses)
        return movableChesses
    }
    
    func lineMovable(num:Int,moveD:direction) -> Array<Bool> {
        var movableChesses = [false,false,false,false]
        
        switch moveD {
        case .Left:
            movableChesses[0] = false
            for col in 1...3 {
                movableChesses[col] = canMove(a: board[num][col - 1], b: board[num][col])
                if movableChesses[col] {
                    for afterCol in col...3 {
                        movableChesses[afterCol] = true
                    }
                    break
                }
            }
        case .Right:
            movableChesses[3] = false
            for col in 0...2 {
                let actualCol = 2 - col
                movableChesses[actualCol] = canMove(a: board[num][actualCol + 1], b: board[num][actualCol])
                if movableChesses[actualCol] {
                    for beforeCol in 0...actualCol {
                        movableChesses[beforeCol] = true
                    }
                    break
                }
            }
        default:
            break
        }
        return movableChesses
    }
    
    func colMovable(moveD:direction,numCol:Int) -> Array<Bool> {
        var movableChesses = [false,false,false,false]
        
        switch moveD {
        case .Up:
            movableChesses[0] = false
            for line in 1...3 {
                movableChesses[line] = canMove(a: board[line-1][numCol], b: board[line][numCol])
                if movableChesses[line] {
                    for afterCol in line...3 {
                        movableChesses[afterCol] = true
                    }
                    break
                }
            }
        case .Down:
            for line in 0...2 {
                movableChesses[3] = false
                let actualLine = 2-line
                movableChesses[actualLine] = canMove(a: board[actualLine][numCol], b: board[actualLine+1][numCol])
                if movableChesses[actualLine] {
                    for beforeCol in 0...actualLine {
                        movableChesses[beforeCol] = true
                    }
                    break
                }
            }
        default:
            break
        }
        return movableChesses
    }
    
    func resetAdded() {
        addedPosition = Array(repeatElement(Array(repeatElement(false, count: 4)), count: 4))
    }
}

