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

final class MyLoginFactory: LoginFactory {
    
    func create() -> LoginInspector {
        return LoginInspector()
    }
    
}
