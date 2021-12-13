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
            self.registerDelegate?.showUsernameError(errorMessage: "This field is required")
            return
        }
        guard self.isNotEmpty(username) else{
            self.registerDelegate?.showUsernameError(errorMessage: "This field is required")
            return
        }
        guard self.isNotTooLong(username) else{
            self.registerDelegate?.showUsernameError(errorMessage: "Username must have least than 10 characters")
            return
        }
        guard let email = optionalEmail else {
            self.registerDelegate?.showEmailError(errorMessage: "This field is required")
            return
        }
        guard self.isNotEmpty(email) else{
            self.registerDelegate?.showEmailError(errorMessage: "This field is required")
            return
        }
        guard self.isValidEmail(email) else{
            self.registerDelegate?.showEmailError(errorMessage: "Email must have \"@\" and least than 10 characters")
            return
        }
        guard let password = optionalPassword else {
            self.registerDelegate?.showPasswordError(errorMessage: "This field is required")
            return
        }
        guard self.isNotEmpty(password) else{
            self.registerDelegate?.showPasswordError(errorMessage: "This field is required")
            return
        }
        guard self.isNotTooLong(password) else{
           self.registerDelegate?.showPasswordError(errorMessage: "Password must have least than 10 characters")
            return
        }
        guard self.usernameNotAlreadyExists(username: username) else{
            self.registerDelegate?.showRegisterUserError(errorMessage: "Username already exists")
            return
        }
        guard self.emailNotAlreadyExists(email: email) else{
            self.registerDelegate?.showRegisterUserError(errorMessage: "Email already exists")
            return
        }
        self.registerDelegate?.succesfulRegister()
    }
}
