//
//  UIViewController+CustomAlertView.swift
//  Imitate_Threes
//
//  Created by 任岐鸣 on 2016/10/11.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert() {
        let alert = CustomAlertView.init(frame: CGRect.zero, title: "Test", detailText: "DetailTest", buttonTitles: ["1","2"])
        alert.show()
        
    }
}

class CustomAlertView: UIView {
    
    var lblTitle = UILabel()
    var lblDetail = UILabel()
    var stackButton = UIStackView()
    var btnTitles = Array<String>()
    
    var overlayView = UIView()
    
    init(frame:CGRect,title:String,detailText:String,buttonTitles:Array<String>?) {
        super.init(frame: frame)
        lblTitle.text = title
        lblDetail.text = detailText
        btnTitles = buttonTitles!
        
        setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        commonInit()
    }
    
    
    private func setView() {
        let window = UIApplication.shared.keyWindow
        stackButton.alignment = UIStackViewAlignment.fill
        stackButton.axis = UILayoutConstraintAxis.horizontal
        stackButton.spacing = CGFloat(1)
        stackButton.distribution = UIStackViewDistribution.fillEqually
        stackButton.backgroundColor = UIColor.blue
        overlayView = UIView.init(frame: (window?.bounds)!)
        self.clipsToBounds = true
        
        addSubview(lblTitle)
        addSubview(lblDetail)
        addSubview(stackButton)
        lblTitle.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        lblDetail.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        stackButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        for btnTitle in btnTitles {
            let button = UIButton.init(x: 0, y: 0, w: 0, h: 0, target: self, action: "hide")
            button.backgroundColor = UIColor.blue
            button.setTitle(btnTitle, for: UIControlState.normal)
            stackButton.addArrangedSubview(button)
        }
    }
    
    func show() {
        let alertDimension:CGFloat = 250
        let window = UIApplication.shared.keyWindow
        let alertViewFrame = CGRect.init(x: (window?.bounds.size.width)!/2 - alertDimension/2, y: (window?.bounds.size.height)!/2 - alertDimension/2, width: alertDimension, height: alertDimension)
        self.frame = alertViewFrame
        
        overlayView.backgroundColor = UIColor.black
        overlayView.alpha = 0.0
        window?.addSubview(overlayView)
        
        self.backgroundColor = UIColor.yellow
        self.alpha = 0.0
        self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize.init(width: 0, height: 5)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 10.0
        window?.addSubview(self)
        weak var weakSelf = self
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            weakSelf?.overlayView.alpha = 0.3
            weakSelf?.alpha = 1.0
            }, completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 14, initialSpringVelocity: 5, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            weakSelf?.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
    }
    
    func hide() {
        weak var weakSelf = self
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            weakSelf?.overlayView.alpha = 0
            weakSelf?.alpha = 0
            }, completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 11, initialSpringVelocity: 5, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            weakSelf?.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            }, completion: nil)
    }
}
