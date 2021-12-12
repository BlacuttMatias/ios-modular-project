//
//  ValidatorSignInUp.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 28/10/2021.
//

import Foundation

protocol StringValidator{}

extension StringValidator{
    func lenghtGreaterThan(text: String, lenght: Int) -> Bool{
        return text.count > lenght
    }
    
    func isTooLong(_ text: String) -> Bool{
        return lenghtGreaterThan(text: text, lenght: 10)
    }
    
    func isNotTooLong(_ text: String) -> Bool{
        return !isTooLong(text)
    }
    
    func isNotEmpty(_ string: String) -> Bool{
        return !string.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    func someOneIsEmpty(args: String...) -> Bool{
        return args.contains { aString in
            aString.isEmpty
        }
    }
}
