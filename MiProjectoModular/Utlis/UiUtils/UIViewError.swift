//
//  UIViewError.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 12/12/2021.
//

import UIKit

class UIViewError: UIView {

    var errorMessageLabel: UILabel = UILabel()
    
    init(){
        super.init(frame: CGRect())
        self.setErrorMessageLabel()
        self.setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setErrorMessage(errorMessage: String){
        self.errorMessageLabel.text = errorMessage
    }
    
    private func setStyle(){
        self.backgroundColor = UIColor(named: Resource.errorBackgroundColor)
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.red.cgColor
        self.alpha = 0
    }
    
    private func setErrorMessageLabel(){
        errorMessageLabel.text = "Username already exists"
        errorMessageLabel.textColor = .red
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.numberOfLines = 0
        
        self.addSubview(errorMessageLabel)
        
        let constraintSetter = ConstraintsSetter(uiView: errorMessageLabel)
        constraintSetter.setCenterXContraint(referenceAnchorView: self.centerXAnchor)
        constraintSetter.setCenterYContraint(referenceAnchorView: self.centerYAnchor)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
