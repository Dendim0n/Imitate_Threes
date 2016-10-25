//
//  ClosureButton.swift
//  Imitate_Threes
//
//  Created by 任岐鸣 on 2016/10/20.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit

class ThreesButton: UIButton {
    
    var lblTitle = UILabel.init()
    var shadowView = UIView.init()
    
    var popHeight:CGFloat = 0
    
    typealias closure = (Void) -> Void
    var doClosure:closure?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    init(buttonColor:UIColor) {
        super.init(frame: .zero)
        lblTitle.backgroundColor = buttonColor
        
        commonInit()
    }
    
    func commonInit() {
        
        popHeight = 10

        shadowView.backgroundColor = backgroundColor(lblTitle.backgroundColor!)
        shadowView.isUserInteractionEnabled = false
        shadowView.layer.cornerRadius = 5
        addSubview(shadowView)
        shadowView.snp.makeConstraints { (make) in
            make.height.equalToSuperview().offset(-popHeight)
            make.width.equalToSuperview()
            make.top.equalToSuperview().offset(popHeight)
            make.centerX.equalToSuperview()
        }
        
        lblTitle.textColor = .white
        lblTitle.adjustsFontSizeToFitWidth = true
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont.Font(FontName.Seravek, type: FontType.Bold, size: 24)
        lblTitle.layer.cornerRadius = 5
        lblTitle.clipsToBounds = true
        addSubview(lblTitle)
        lblTitle.snp.makeConstraints { (make) in
            make.height.equalToSuperview().offset(-popHeight)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        lblTitle.snp.updateConstraints { (make) in
            make.height.equalToSuperview().offset(-popHeight)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(popHeight)
        }
        self.layoutIfNeeded()
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        touchEnding()
    }
    override func cancelTracking(with event: UIEvent?) {
        touchEnding()
    }
    private func touchEnding() {
        lblTitle.snp.updateConstraints { (make) in
            make.height.equalToSuperview().offset(-popHeight)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        self.layoutIfNeeded()
    }
    private func backgroundColor(_ color:UIColor) -> UIColor? {
        var hue:CGFloat = 0,saturation:CGFloat = 0,brightness:CGFloat = 0,alpha:CGFloat = 0
        if color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return UIColor.init(hue: hue, saturation: saturation, brightness: brightness*0.7, alpha: alpha)
        }
        return nil
        
    }
}
