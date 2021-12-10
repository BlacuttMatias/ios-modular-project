//
//  UITextField+Extension.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 10/12/2021.
//

import Foundation

extension UITextField{
    func setRoundedBorders(){
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.setDefaultBorderColor()
    }
    
    func setBorderRed(){
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.red.cgColor
    }
    
    func setDefaultBorderColor(){
        self.layer.borderColor = UIColor(displayP3Red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0).cgColor
    }
    
    func animateError(){
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = 4
        animation.duration = 0.2/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values = [10, -10]
        self.layer.add(animation, forKey: "shake")
        UIView.animate(withDuration: 1, animations: {
            self.setBorderRed()
        })
    }
}
