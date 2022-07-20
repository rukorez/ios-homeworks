//
//  LoginError.swift
//  Navigation
//
//  Created by Филипп Степанов on 04.07.2022.
//

import Foundation
import UIKit

enum LoginError: Error {
    case wrongLogin
    case wrongPassword
    
    var localizedDescription: String {
        switch self {
        case .wrongLogin:
            return "Неверный логин"
        case .wrongPassword:
            return "Неверный пароль"
        }
    }
}
