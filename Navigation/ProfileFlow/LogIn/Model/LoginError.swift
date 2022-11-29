//
//  LoginError.swift
//  Navigation
//
//  Created by Филипп Степанов on 04.07.2022.
//

import Foundation
import UIKit

protocol LoginErrorProtocol: Error {
    var localizedDescription: String { get }
}

enum LoginError: LoginErrorProtocol {
    case wrongLogin
    case wrongPassword
    case wrongUser
    case serverError
    
    var localizedDescription: String {
        switch self {
        case .wrongLogin:
            return NSLocalizedString("loginErrorWrongLogin", comment: "")
        case .wrongPassword:
            return NSLocalizedString("loginErrorWrongPassword", comment: "")
        case .wrongUser:
            return NSLocalizedString("loginErrorWrongUser", comment: "")
        case .serverError:
            return NSLocalizedString("loginErrorServerError", comment: "")
        }
    }
}

enum RegisterError: LoginErrorProtocol {
    
    case wrongEmail
    case shortPassword
    case doubleUser
    case serverError
    
    var localizedDescription: String {
        switch self {
        case .wrongEmail:
            return NSLocalizedString("registerErrorWrongLogin", comment: "")
        case .shortPassword:
            return NSLocalizedString("registerErrorShortPassword", comment: "")
        case .doubleUser:
            return NSLocalizedString("registerErrorDoubleUser", comment: "")
        case .serverError:
            return NSLocalizedString("registerErrorServerError", comment: "")
        }
    }
}
