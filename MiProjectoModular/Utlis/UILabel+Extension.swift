//
//  UILabel+Extension.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 25/11/2021.
//

import Foundation
extension UILabel{
    func setFontSize(_ size: CGFloat){
        self.font = UIFont.systemFont(ofSize: size)
    }
    
    func setFontSizeIn18(){
        self.setFontSize(18)
    }
}
