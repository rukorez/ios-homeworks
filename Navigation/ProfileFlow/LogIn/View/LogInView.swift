//
//  LogInView.swift
//  Navigation
//
//  Created by Филипп Степанов on 07.09.2021.
//

import UIKit

final class LogInView: UIView {
    
    lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    
    private lazy var logo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    lazy var login: UITextField = {
        let login = UITextField()
        login.translatesAutoresizingMaskIntoConstraints = false
        login.textColor = .black
        login.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        login.placeholder = "Email or phone"
        login.tintColor = UIColor(named: "AccentColor")
        login.autocapitalizationType = .none
        login.clearButtonMode = .whileEditing
        return login
    }()
    
    private lazy var separator: UIView = {
        var separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = UIColor.lightGray
        return separator
    }()
    
    lazy var password: UITextField = {
        let password = UITextField()
        password.translatesAutoresizingMaskIntoConstraints = false
        password.placeholder = "Password"
        password.isSecureTextEntry = true
        password.clearButtonMode = .whileEditing
//        password.clearsOnBeginEditing = true
        return password
    }()
    
    lazy var loginPasswordView: UIView = {
        let loginview = UIView()
        loginview.translatesAutoresizingMaskIntoConstraints = false
        loginview.layer.borderWidth = 0.5
        loginview.layer.borderColor = UIColor.lightGray.cgColor
        loginview.layer.cornerRadius = 10
        loginview.clipsToBounds = true
        loginview.backgroundColor = .systemGray6
        return loginview
    }()
    
    lazy var loginButton: CustomButton = {
        var button = CustomButton(title: "Log In", titleColor: .white, backgroundColor: .clear)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setBackgroundImage(UIImage(named: "BluePix")?.copy(alpha: 1), for: .normal)
        button.setBackgroundImage(UIImage(named: "BluePix")?.copy(alpha: 0.8), for: .selected)
        button.setBackgroundImage(UIImage(named: "BluePix")?.copy(alpha: 0.8), for: .highlighted)
        button.setBackgroundImage(UIImage(named: "BluePix")?.copy(alpha: 0.8), for: .disabled)
        return button
    }()
    
    lazy var generateButton: CustomButton = {
        var button = CustomButton(title: "Подобрать пароль", titleColor: .systemBlue, backgroundColor: .clear)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViews() {
        backgroundColor = .white
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(logo)
        contentView.addSubview(loginPasswordView)
        contentView.addSubview(loginButton)
        contentView.addSubview(generateButton)
        contentView.addSubview(activityIndicator)
        
        loginPasswordView.addSubview(login)
        loginPasswordView.addSubview(password)
        loginPasswordView.addSubview(separator)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - Constraints
extension LogInView {
    private func setConstraints() {
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            logo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logo.widthAnchor.constraint(equalToConstant: 100),
            logo.heightAnchor.constraint(equalTo: logo.widthAnchor),
            
            loginPasswordView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 120),
            loginPasswordView.heightAnchor.constraint(equalToConstant: 100),
            loginPasswordView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginPasswordView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            loginButton.topAnchor.constraint(equalTo: loginPasswordView.bottomAnchor, constant: 16),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            generateButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30),
            generateButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            activityIndicator.topAnchor.constraint(equalTo: generateButton.bottomAnchor, constant: 16),
            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            login.topAnchor.constraint(equalTo: loginPasswordView.topAnchor),
            login.trailingAnchor.constraint(equalTo: loginPasswordView.trailingAnchor),
            login.leadingAnchor.constraint(equalTo: loginPasswordView.leadingAnchor, constant: 10),
            login.heightAnchor.constraint(equalToConstant: 50),
            
            separator.widthAnchor.constraint(equalTo: loginPasswordView.widthAnchor),
            separator.heightAnchor.constraint(equalToConstant: 0.5),
            separator.topAnchor.constraint(equalTo: login.bottomAnchor),
            
            password.bottomAnchor.constraint(equalTo: loginPasswordView.bottomAnchor),
            password.trailingAnchor.constraint(equalTo: loginPasswordView.trailingAnchor),
            password.leadingAnchor.constraint(equalTo: loginPasswordView.leadingAnchor, constant: 10),
            password.heightAnchor.constraint(equalToConstant: 50),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

