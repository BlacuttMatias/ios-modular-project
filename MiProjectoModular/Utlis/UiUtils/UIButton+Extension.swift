//
//  UIButton+Extension.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 25/11/2021.
//

import Foundation

extension UIButton{
    func roundedBorder(){
        self.layer.cornerRadius = 10.0
    }
    
    func setBlueIcon(){
        self.contentVerticalAlignment = .fill
        self.contentHorizontalAlignment = .fill
        self.setTitleColor(UIColor.blue, for: .normal)
    }
    
    func setActionButtonText(sizeFont: CGFloat){
        self.roundedBorder()
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: sizeFont)
        self.tintColor = .white
        self.backgroundColor = UIColor(named: Resource.buttonColor)
        
    }
    
    func animateError(){
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = 4
        animation.duration = 0.2/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values = [10, -10]
        self.layer.add(animation, forKey: "shake")
    }

}
