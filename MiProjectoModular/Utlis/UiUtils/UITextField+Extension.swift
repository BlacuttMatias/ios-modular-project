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
    
    private func setErrorConstraintsImage(errorImageView: UIImageView){
        let constraintSetter = ConstraintsSetter(uiView: errorImageView)
        constraintSetter.setHeightConstraint(height: self.frame.height-15)
        constraintSetter.setWidthConstraint(width: self.frame.height-15)
    }
    
    func setErrorStyle(){
        self.setRoundedBorders()
        let errorImage = UIImage(named: Resource.errorIcon)?.withTintColor(.red)
        let errorImageView = UIImageView(image: errorImage)
        self.setErrorConstraintsImage(errorImageView: errorImageView)
        errorImageView.alpha = 0
        self.rightView = errorImageView
        self.rightViewMode = .always
    }
    
    private func showErrorStyle(){
        self.setBorderRed()
        self.rightView?.alpha = 1
    }
    
    func hideErrorStyle(){
        self.setDefaultBorderColor()
        self.rightView?.alpha = 0
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
            self.showErrorStyle()
        })
    }
}
