//
//  LoginInspector.swift
//  Navigation
//
//  Created by Филипп Степанов on 27.01.2022.
//

import Foundation
import UIKit

class LoginChecker {
    
    static let shared = LoginChecker()
    
    private let login = "Filipp"
    
    private let password = "123456"
    
    private init() {}
    
    func check(login: String, password: String) -> Bool {
        if login == self.login && password == self.password {
            return true
        } else {
            return false
        }
    }
}


protocol LoginViewControllerDelegate {
    
    func checkLogin(login: String, password: String) -> Bool
    
}

class LoginInspector: LoginViewControllerDelegate {
    
    func checkLogin(login: String, password: String) -> Bool {
        if LoginChecker.shared.check(login: login, password: password) {
            return true
        } else {
            return false
        }
    }
    
}
