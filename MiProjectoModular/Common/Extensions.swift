//
//  Extensions.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 06/12/2021.
//

import Foundation
import UIKit

extension UIViewController{
    func showSimpleAlert(title: String?, message: String?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // set label error of input of textfield
    func setErrorLabel(label: UILabel, textField: UITextField){
        label.setErrorStyle()
        label.numberOfLines = 0
        self.view.addSubview(label)
        
        let constraintSetter = ConstraintsSetter(uiView: label)
        constraintSetter.setTopEqualContraint(referenceAnchorView: textField.bottomAnchor, distance: 8)
        constraintSetter.setWidthConstraint(width: textField.frame.width)
        constraintSetter.setLeftEqualContraint(referenceAnchorView: textField.leadingAnchor, distance: 0)
    }
    
    func showLabelError(label: UILabel, errorMessage: String){
        label.text = errorMessage
        UIView.animate(withDuration: 1, animations: {
            label.alpha = 1
        })
    }
}
protocol UiMenuCreator{
    func createUiMenu(actions: [ActionMenuButton]?, title: String?) -> UIMenu
}

extension UiMenuCreator{
    func createUiMenu(actions: [ActionMenuButton]?, title: String?) -> UIMenu{
        return MenuCreator().createMenu(withActions: actions ?? [], title: title ?? "")
    }
}
