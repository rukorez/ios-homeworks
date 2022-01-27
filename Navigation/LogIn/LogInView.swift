//
//  LogInView.swift
//  Navigation
//
//  Created by Филипп Степанов on 07.09.2021.
//

import UIKit

class LogInView: UIView {

    var login: UITextField = {
        let login = UITextField()
        login.translatesAutoresizingMaskIntoConstraints = false
        login.textColor = .black
        login.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        login.placeholder = "Email or phone"
        login.tintColor = UIColor(named: "AccentColor")
        login.autocapitalizationType = .none
        return login
    }()
    
    var separator: UIView = {
        var separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = UIColor.lightGray
        return separator
    }()
    
    var password: UITextField = {
        let password = UITextField()
        password.translatesAutoresizingMaskIntoConstraints = false
        password.placeholder = "Password"
        password.isSecureTextEntry = true
        return password
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(login)
        self.addSubview(password)
        self.addSubview(separator)
        self.backgroundColor = .systemGray6
        
        let constraint = [
            self.login.topAnchor.constraint(equalTo: self.topAnchor),
            self.login.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.login.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.login.heightAnchor.constraint(equalToConstant: 50),
            
            self.separator.widthAnchor.constraint(equalTo: self.widthAnchor),
            self.separator.heightAnchor.constraint(equalToConstant: 0.5),
            self.separator.topAnchor.constraint(equalTo: self.login.bottomAnchor),
            
            self.password.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.password.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.password.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.password.heightAnchor.constraint(equalToConstant: 50),
        ]
        NSLayoutConstraint.activate(constraint)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
