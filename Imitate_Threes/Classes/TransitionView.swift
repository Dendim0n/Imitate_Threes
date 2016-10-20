//
//  TransitionView.swift
//  TransitionView
//
//  Created by 任岐鸣 on 2016/10/19.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit

class TransitionView: UIView {
    
    var currentView = UIView.init()
    
    enum Direction {
        case top
        case bottom
        case left
        case right
        case alpha
    }
    
    
    
    init() {
        super.init(frame: CGRect.zero)
        commonInit()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(currentView)
    }
    
    func setView (_ view:UIView) {
        currentView.removeFromSuperview()
        currentView = view
        addSubview(view)
        view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func transitionToView(_ view:UIView,from:Direction) {
        addSubview(view)
        view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        var transform:CGAffineTransform
        switch from {
        case .top:
            transform = CGAffineTransform.init(translationX: 0, y: -self.frame.height)
        case .bottom:
            transform = CGAffineTransform.init(translationX: 0, y: self.frame.height)
        case .left:
            transform = CGAffineTransform.init(translationX: -self.frame.height, y: 0)
        case .right:
            transform = CGAffineTransform.init(translationX: self.frame.height, y: 0)
        case .alpha:
            transform = CGAffineTransform.init(translationX: 0, y: 0)
        }
        view.transform = transform
        view.alpha = 0.0
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            view.transform = CGAffineTransform.init(translationX: 0, y: 0)
            view.alpha = 1.0
            self.currentView.alpha = 0
            }, completion: {
                Bool in
                self.currentView.removeFromSuperview()
                self.currentView = view
        })
        
    }
    
}
