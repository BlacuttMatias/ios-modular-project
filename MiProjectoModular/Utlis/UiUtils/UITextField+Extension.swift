//
//  UITextField+Extension.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 10/12/2021.
//

import Foundation

extension UITextField{
    func setRoundedBorders(){
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
    }
    
    func setBorderRed(){
        self.layer.borderColor = UIColor.red.cgColor
    }
    
    func setBorderWhite(){
        self.layer.borderColor = UIColor.white.cgColor
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
