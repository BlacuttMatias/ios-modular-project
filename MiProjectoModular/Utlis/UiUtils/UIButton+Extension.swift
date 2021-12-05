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
}
