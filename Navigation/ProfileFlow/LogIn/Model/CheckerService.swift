//
//  CheckerService.swift
//  Navigation
//
//  Created by Филипп Степанов on 01.09.2022.
//

import Foundation
import FirebaseAuth

protocol CheckerServiceProtocol {
    func checkCredentials(login: String, password: String)
    func signUp(login: String, password: String)
}

final class CheckerService: CheckerServiceProtocol {
    
    var error: LoginErrorProtocol?
    
    var isRegister: Bool = false
    
    func checkCredentials(login: String, password: String) {
        Auth.auth().signIn(withEmail: login, password: password) { result, error in
            if error == nil {
                guard let result = result else { return }
                print(result.user.uid)
                self.isRegister = true
            } else {
                guard let error = error else { return }
                switch error.localizedDescription {
                case "The password is invalid or the user does not have a password.": self.error = LoginError.wrongPassword
                case "The email address is badly formatted.": self.error = LoginError.wrongLogin
                case "There is no user record corresponding to this identifier. The user may have been deleted.": self.error = LoginError.wrongUser
                case "Network error (such as timeout, interrupted connection or unreachable host) has occurred.": self.error = LoginError.serverError
                default: print(error.localizedDescription)
                }
            }
        }
    }
    
    func signUp(login: String, password: String) {
        Auth.auth().createUser(withEmail: login, password: password) { result, error in
            if error == nil {
                if let result = result {
                    print(result.user.uid)
                }
            } else {
                guard let error = error else { return }
                switch error.localizedDescription {
                case "The password must be 6 characters long or more.": self.error = RegisterError.shortPassword
                case "The email address is badly formatted.": self.error = RegisterError.wrongEmail
                case "The email address is already in use by another account.": self.error = RegisterError.doubleUser
                case "Network error (such as timeout, interrupted connection or unreachable host) has occurred.": self.error = RegisterError.serverError
                default: print(error.localizedDescription)
                }
            }
        }
    }
    
    
    
    
}
