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
//    func checkLogin(login: String, password: String)
//    func register(login: String, password: String)
    
}

class LoginInspector: LoginViewControllerDelegate {
    
//    let checker = CheckerService()
    
    func checkLogin(login: Int, password: Int) -> (Bool, String?) {
        let loginCheckerResult = LoginChecker.shared.check(login: login, password: password)
        if loginCheckerResult.0 {
            return (true, nil)
        } else {
            return (false, loginCheckerResult.1)
        }
    }
    
//    func checkLogin(login: String, password: String) {
//        checker.checkCredentials(login: login, password: password)
//    }
//
//    func register(login: String, password: String) {
//        checker.signUp(login: login, password: password)
//    }
    
}
