//
//  Model.swift
//  Navigation
//
//  Created by Филипп Степанов on 28.03.2022.
//

import Foundation

final class Model {
    
    private let password = "Password"

    func check(word: String) {
        if word == password {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "correct password") , object: nil)
        } else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "incorrect password"), object: nil)
        }
    }
    
}

