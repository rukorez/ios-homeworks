//
//  Factory.swift
//  Navigation
//
//  Created by Филипп Степанов on 29.01.2022.
//

import Foundation

protocol LoginFactory {
    
    func create() -> LoginInspector
    
}

class MyLoginFactory: LoginFactory {
    
    func create() -> LoginInspector {
        return LoginInspector()
    }
    
}
