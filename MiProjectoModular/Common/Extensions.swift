//
//  Extensions.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 06/12/2021.
//

import Foundation

extension UIViewController{
    func showSimpleAlert(title: String?, message: String?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
