//
//  Errors.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 15/11/2021.
//

import Foundation

protocol CustomError{
    var description: String { get }
}

struct UrlNotExists: Error{
    var description: String
    
    init(){
        self.description = "The URL not exists"
    }
}
