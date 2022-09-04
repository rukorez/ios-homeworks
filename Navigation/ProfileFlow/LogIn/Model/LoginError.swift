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
            return "Некорректный email."
        case .wrongPassword:
            return "Неверный пароль"
        case .wrongUser:
            return "Такой пользователь не зарегистрирован."
        case .serverError:
            return "Отсутствует подключение к сети. Проверьте настройки интернета и попробуйте еще раз."
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
            return "Некорректный email."
        case .shortPassword:
            return "Пароль слишком короткий. Пароль должен содержать не менее 6 символов."
        case .doubleUser:
            return "Пользователь с таким email-адресом уже существует."
        case .serverError:
            return "Отсутствует подключение к сети. Проверьте настройки интернета и попробуйте еще раз."
        }
    }
}
