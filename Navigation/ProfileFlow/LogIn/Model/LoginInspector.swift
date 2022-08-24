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
    
    public let password = "1234"
    
    private init() {}
    
    func check(login: Int, password: Int) -> (Bool, String?) {
        if login == self.login.hash && password == self.password.hash {
            return (true, nil)
        } else if login != self.login.hash {
            return (false, LoginError.wrongLogin.localizedDescription)
        } else if password != self.password.hash {
            return (false, LoginError.wrongPassword.localizedDescription)
        } else {
            return (false, nil)
        }
    }
}


protocol LoginViewControllerDelegate {
    
    func checkLogin(login: Int, password: Int) -> (Bool, String?)
    
}

class LoginInspector: LoginViewControllerDelegate {
    
    func checkLogin(login: Int, password: Int) -> (Bool, String?) {
        if LoginChecker.shared.check(login: login, password: password).0 {
            return (true, nil)
        } else {
            return (false, LoginChecker.shared.check(login: login, password: password).1)
        }
    }
    
}
