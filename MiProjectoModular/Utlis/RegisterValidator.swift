//
//  ValidatorRegister.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 28/10/2021.
//

import Foundation

class RegisterValidator: StringValidator{

    func isValidEmail(_ email: String) -> Bool{
        return !email.isEmpty && isNotTooLong(email) && email.contains("@")
    }
    
    func isNotValidEmail(_ email: String) -> Bool{
        return !isValidEmail(email)
    }
}