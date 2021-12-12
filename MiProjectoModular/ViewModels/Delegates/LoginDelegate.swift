//
//  LoginDelegate.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 12/12/2021.
//

import Foundation

protocol LoginDelegate: AnyObject{
    func showUsernameEmailError(errorMessage: String)
    func showPasswordError(errorMessage: String)
    func showLoginUserError(errorMessage: String)
    func succesfulLogin()
}
