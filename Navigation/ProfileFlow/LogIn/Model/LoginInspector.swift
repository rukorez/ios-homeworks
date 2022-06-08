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
    
    public let password = "123456"
    
    private init() {}
    
    func check(login: Int, password: Int) -> Bool {
        if login == self.login.hash && password == self.password.hash {
            return true
        } else {
            return false
        }
    }
}


protocol LoginViewControllerDelegate {
    
    func checkLogin(login: Int, password: Int) -> Bool
    
}

class LoginInspector: LoginViewControllerDelegate {
    
    func checkLogin(login: Int, password: Int) -> Bool {
        if LoginChecker.shared.check(login: login, password: password) {
            return true
        } else {
            return false
        }
    }
    
}
