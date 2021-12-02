//
//  ValidatorSingIn.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 28/10/2021.
//

import Foundation

class LoginValidator: StringValidator{
    
    let registered = Registered()

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
}