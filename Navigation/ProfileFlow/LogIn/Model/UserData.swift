//
//  UserData.swift
//  Navigation
//
//  Created by Филипп Степанов on 20.12.2021.
//

import Foundation
import UIKit

class User {
    var fullName: String?
    var avatar: UIImage?
    var status: String?
}

protocol UserService {
    func userName(name: String) -> User
}

class CurrentUserService: UserService {
    
    var user = User()
    
    func userName(name: String) -> User {
        guard name == user.fullName else { return User() }
        return user
    }
    
}

class TestUserService: UserService {
    
    var user: User = {
        var user = User()
        user.fullName = "Filipp Stepanov"
        user.avatar = UIImage(systemName: "person")
        user.status = "Online"
        return user
    }()
    
    func userName(name: String) -> User {
        guard name == user.fullName else { return User() }
        return user
    }
}
