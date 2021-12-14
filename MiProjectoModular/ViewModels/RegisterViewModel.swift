//
//  ValidatorRegister.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 28/10/2021.
//

import Foundation

class RegisterViewModel: StringValidator{
    
    let registered = Registered()
    private weak var registerDelegate: RegisterDelegate?
    
    func setRegisterDelegate(registerDelegate: RegisterDelegate){
        self.registerDelegate = registerDelegate
    }

    func isValidEmail(_ email: String) -> Bool{
        return !email.isEmpty && isNotTooLong(email) && email.contains("@")
    }
    
    func isNotValidEmail(_ email: String) -> Bool{
        return !isValidEmail(email)
    }
    
    func getNameWelcomeViewController() -> String{
        return "TabViewController"
    }
    
    func usernameAlreadyExists(username: String) -> Bool{
        return registered.exists(username: username)
    }
    
    func emailAlreadyExists(email: String) -> Bool{
        return registered.exists(email: email)
    }
    
    func usernameNotAlreadyExists(username: String) -> Bool{
        return !self.usernameAlreadyExists(username: username)
    }
    
    func emailNotAlreadyExists(email: String) -> Bool{
        return !self.emailAlreadyExists(email: email)
    }
    
    func register(optionalUsername: String?, optionalEmail: String?, optionalPassword: String?){
        guard let username = optionalUsername else {
            self.registerDelegate?.showUsernameError(errorMessage: ErrorSignInUp.emptyField.rawValue)
            return
        }
        guard self.isNotEmpty(username) else{
            self.registerDelegate?.showUsernameError(errorMessage: ErrorSignInUp.emptyField.rawValue)
            return
        }
        guard self.isNotTooLong(username) else{
            self.registerDelegate?.showUsernameError(errorMessage: ErrorSignInUp.usernameTooLong.rawValue)
            return
        }
        guard let email = optionalEmail else {
            self.registerDelegate?.showEmailError(errorMessage: ErrorSignInUp.emptyField.rawValue)
            return
        }
        guard self.isNotEmpty(email) else{
            self.registerDelegate?.showEmailError(errorMessage: ErrorSignInUp.emptyField.rawValue)
            return
        }
        guard self.isValidEmail(email) else{
            self.registerDelegate?.showEmailError(errorMessage: ErrorSignInUp.notValidEmail.rawValue)
            return
        }
        guard let password = optionalPassword else {
            self.registerDelegate?.showPasswordError(errorMessage: ErrorSignInUp.emptyField.rawValue)
            return
        }
        guard self.isNotEmpty(password) else{
            self.registerDelegate?.showPasswordError(errorMessage: ErrorSignInUp.emptyField.rawValue)
            return
        }
        guard self.isNotTooLong(password) else{
            self.registerDelegate?.showPasswordError(errorMessage: ErrorSignInUp.passwordTooLong.rawValue)
            return
        }
        guard self.usernameNotAlreadyExists(username: username) else{
            self.registerDelegate?.showUsernameError(errorMessage: ErrorSignInUp.usernameAlreadyExists.rawValue)
            return
        }
        guard self.emailNotAlreadyExists(email: email) else{
            self.registerDelegate?.showEmailError(errorMessage: ErrorSignInUp.emailAlreadyExists.rawValue)
            return
        }
        self.registerDelegate?.succesfulRegister()
    }
}
