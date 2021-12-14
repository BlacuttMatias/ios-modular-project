//
//  LoginViewModel.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 01/12/2021.
//

import Foundation

class LoginViewModel: StringValidator{
    
    private let registered = Registered()
    private weak var loginDelegate: LoginDelegate?

    func setLoginDelegate(loginDelegate: LoginDelegate){
        self.loginDelegate = loginDelegate
    }
    
    func usernameOrEmailIsVallid(usernameOrEmail: String) -> Bool{
        return !usernameOrEmail.isEmpty && isNotTooLong(usernameOrEmail)
    }
    
    func usernameOrEmailIsNotVallid(usernameOrEmail: String) -> Bool{
        return !usernameOrEmailIsVallid(usernameOrEmail: usernameOrEmail)
    }
    
    func isAEmail(possibleEmail: String) -> Bool{
        return possibleEmail.contains("@")
    }
    
    func isRegistered(usernameOrEmail: String, password: String) -> Bool{
        var account: Account
        if isAEmail(possibleEmail: usernameOrEmail){
            account = Account(username: "", email: usernameOrEmail, pass: password)
        }
        else{
            account = Account(username: usernameOrEmail, email: "", pass: password)
        }
        return registered.isRegistered(account: account)
    }
    
    func getNameWelcomeViewController() -> String{
        return "TabViewController"
    }
    
    func login(optionalUsernameOrEmail: String?, optionalPassword: String?){
        guard let usernameOrEmail = optionalUsernameOrEmail else {
            self.loginDelegate?.showUsernameEmailError(errorMessage: ErrorSignInUp.emptyField.rawValue)
            return
        }
        guard self.isNotEmpty(usernameOrEmail) else{
            self.loginDelegate?.showUsernameEmailError(errorMessage: ErrorSignInUp.emptyField.rawValue)
            return
        }
        guard self.isNotTooLong(usernameOrEmail) else{
            self.loginDelegate?.showUsernameEmailError(errorMessage: ErrorSignInUp.usernameTooLong.rawValue)
            return
        }
        guard let password = optionalPassword else {
            self.loginDelegate?.showPasswordError(errorMessage: ErrorSignInUp.emptyField.rawValue)
            return
        }
        guard self.isNotEmpty(password) else{
            self.loginDelegate?.showPasswordError(errorMessage: ErrorSignInUp.emptyField.rawValue)
            return
        }
        guard self.isNotTooLong(password) else{
            self.loginDelegate?.showPasswordError(errorMessage: ErrorSignInUp.passwordTooLong.rawValue)
            return
        }
        guard self.isRegistered(usernameOrEmail: usernameOrEmail, password: password) else{
            self.loginDelegate?.showLoginUserError(errorMessage: ErrorSignInUp.userNotExists.rawValue)
            return
        }
        self.loginDelegate?.succesfulLogin()
    }
}
