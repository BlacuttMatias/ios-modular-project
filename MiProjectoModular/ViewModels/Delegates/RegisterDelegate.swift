//
//  RegisterDelegate.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 13/12/2021.
//

import Foundation

protocol RegisterDelegate: AnyObject{
    func showUsernameError(errorMessage: String)
    func showEmailError(errorMessage: String)
    func showPasswordError(errorMessage: String)
    func showRegisterUserError(errorMessage: String)
    func succesfulRegister()
}
