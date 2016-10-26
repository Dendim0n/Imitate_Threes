//
//  UIViewController+CustomAlertView.swift
//  Imitate_Threes
//
//  Created by 任岐鸣 on 2016/10/11.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title:String,detailText:String,buttonTitles:Array<String>,buttonClosures:[CustomAlertView.closure?]?) {
        let alert = CustomAlertView.init(frame: CGRect.zero, title: title, detailText: detailText, buttonTitles: buttonTitles, buttonClosures:buttonClosures as! [CustomAlertView.closure]?)
        DispatchQueue.main.async { 
            alert.show()
        }
    }
}

class CustomAlertView: UIView {
    
    typealias closure = (Void) -> Void
    
    var lblTitle = UILabel()
    var lblDetail = UILabel()
    var stackButton = UIStackView()
    var btnTitles = Array<String>()
    
    var closures:[closure]?
    
    var overlayView = UIView()
    
    init(frame:CGRect,title:String,detailText:String,buttonTitles:Array<String>?,buttonClosures:[closure]?) {
        super.init(frame: frame)
        lblTitle.text = title
        lblDetail.text = detailText
        btnTitles = buttonTitles!
        closures = buttonClosures
        print(btnTitles)
        setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        commonInit()
    }
    
    
    private func setView() {
        let bgViewForStack = UIView.init()
        let window = UIApplication.shared.keyWindow!
        stackButton.alignment = UIStackViewAlignment.fill
        stackButton.axis = UILayoutConstraintAxis.horizontal
        stackButton.spacing = CGFloat(1)
        stackButton.distribution = UIStackViewDistribution.fillEqually
        stackButton.backgroundColor = UIColor.blue
//        self.roundCorners(.allCorners, radius: 10)
        overlayView = UIView.init(frame: window.bounds)
        self.clipsToBounds = false
        bgViewForStack.roundCorners([.bottomLeft,.bottomRight], radius: 10)
        bgViewForStack.clipsToBounds = true
        
        addSubview(lblTitle)
        addSubview(lblDetail)
        addSubview(bgViewForStack)
        /*bgViewForStack.*/addSubview(stackButton)
        lblTitle.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        lblDetail.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        stackButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
//        stackButton.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview()
//        }
        if btnTitles.count > (closures?.count)! {
            var minClosureCount = (closures?.count)! - 1
            if minClosureCount < 0 {
                minClosureCount = 0
            }
            for _ in minClosureCount...btnTitles.count - 1 {
                let nilClosure = {}
                closures?.append(nilClosure)
            }
        }
        for i in 0...btnTitles.count - 1 {
            let button = ThreesButton.init(buttonColor: UIColor.init(r: 41, g: 142, b: 11))
            button.addTarget(self, action: #selector(CustomAlertView.hide), for: UIControlEvents.touchUpInside)
            button.lblTitle.text = btnTitles[i]
            button.lblTitle.textColor = .white
            //            print(button.titleLabel?.frame)
            button.setTitleColor(.white, for: .normal)
            button.setCornerRadius(radius: 8)
            button.doClosure = closures?[i]
            stackButton.addArrangedSubview(button)
        }
//        for btnTitle in btnTitles {
//            let button = ThreesButton.init(buttonColor: UIColor.init(r: 41, g: 142, b: 11))
//            button.addTarget(self, action: #selector(CustomAlertView.hide), for: UIControlEvents.touchUpInside)
//            button.lblTitle.text = btnTitle
//            button.lblTitle.textColor = .white
////            print(button.titleLabel?.frame)
//            button.setTitleColor(.white, for: .normal)
//            button.setCornerRadius(radius: 8)
//            
//            stackButton.addArrangedSubview(button)
//        }
    }
    
    func show() {
        let alertDimension:CGFloat = 250
        let window = UIApplication.shared.keyWindow!
        let alertViewFrame = CGRect.init(x: window.bounds.size.width/2 - alertDimension/2, y: window.bounds.size.height, width: alertDimension, height: alertDimension)
        self.frame = alertViewFrame
        
        overlayView.backgroundColor = UIColor.black
        overlayView.alpha = 0.0
        window.addSubview(overlayView)
        
        self.backgroundColor = UIColor.white
        self.alpha = 1.0
        
        self.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize.init(width: 5, height: 5)
        self.layer.shadowOpacity = 0.6
        self.layer.shadowRadius = 10.0
        window.addSubview(self)
        weak var weakSelf = self
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            weakSelf?.overlayView.alpha = 0.3
            weakSelf?.alpha = 1.0
            }, completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5, options: UIViewAnimationOptions.allowAnimatedContent, animations: {
            weakSelf?.transform = CGAffineTransform(scaleX: 1, y: 1)
            weakSelf?.frame = CGRect.init(x: window.bounds.size.width/2 - alertDimension/2, y: window.bounds.size.height/2 - alertDimension/2, width: alertDimension, height: alertDimension)
            }, completion: nil)
    }
    
    func hide() {
        weak var weakSelf = self
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            weakSelf?.overlayView.alpha = 0
            weakSelf?.alpha = 0
            }, completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 11, initialSpringVelocity: 5, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            weakSelf?.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
            }, completion: {
                Bool in
                weakSelf?.overlayView.removeFromSuperview()
                self.removeFromSuperview()
        })
    }
}
