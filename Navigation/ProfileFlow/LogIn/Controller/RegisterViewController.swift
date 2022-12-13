//
//  RegisterViewController.swift
//  Navigation
//
//  Created by Филипп Степанов on 02.09.2022.
//

import UIKit

protocol RegisterViewControllerDelegate {
    
}

class RegisterViewController: UIViewController {
    
    var coordinator: ProfileCoordinator?
    
    var colors = LoginViewColors()
    
    var delegate: LoginViewControllerDelegate?
    
    var loginVC: LogInViewController?
    
    lazy var login: UITextField = {
        let login = UITextField()
        login.translatesAutoresizingMaskIntoConstraints = false
        login.textColor = colors.loginTextColor
        login.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        login.placeholder = NSLocalizedString("loginViewLoginTextFieldPlaceholder", comment: "")
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
        password.placeholder = NSLocalizedString("loginViewPasswordTextFieldPlaceholder", comment: "")
        password.isSecureTextEntry = true
        password.clearButtonMode = .whileEditing
        return password
    }()
    
    lazy var loginPasswordView: UIView = {
        let loginview = UIView()
        loginview.translatesAutoresizingMaskIntoConstraints = false
        loginview.layer.borderWidth = 0.5
        loginview.layer.borderColor = UIColor.lightGray.cgColor
        loginview.layer.cornerRadius = 10
        loginview.clipsToBounds = true
        loginview.backgroundColor = colors.loginViewBackgroundColor
        return loginview
    }()
    
    lazy var loginButton: CustomButton = {
        var button = CustomButton(title: NSLocalizedString("registerViewButtonTitle", comment: ""), titleColor: .white, backgroundColor: .clear)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setBackgroundImage(UIImage(named: "BluePix")?.copy(alpha: 1), for: .normal)
        button.setBackgroundImage(UIImage(named: "BluePix")?.copy(alpha: 0.8), for: .selected)
        button.setBackgroundImage(UIImage(named: "BluePix")?.copy(alpha: 0.8), for: .highlighted)
        button.setBackgroundImage(UIImage(named: "BluePix")?.copy(alpha: 0.8), for: .disabled)
        button.isEnabled = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setViews()
        setConstraints()
        hideKeyboardInViewController()
        setTarget()
        login.delegate = self
        password.delegate = self
    }
    
    private func setViews() {
        view.backgroundColor = colors.backgroundColor
        
        view.addSubview(loginPasswordView)
        view.addSubview(loginButton)
        
        loginPasswordView.addSubview(login)
        loginPasswordView.addSubview(password)
        loginPasswordView.addSubview(separator)
    }
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if login.text == "" && password.text == "" {
            loginButton.isEnabled = false
        } else {
            loginButton.isEnabled = true
        }
    }
    
    private func setTarget() {
        loginButton.onTap = {
            guard let login = self.login.text, let password = self.password.text else { return }
            RealmUserModel.defaultModel.addUser(login: login, password: password)
            let alertVC = UIAlertController(title: NSLocalizedString("registerViewAlertTitle", comment: ""), message: NSLocalizedString("registerViewAlertMessage", comment: ""), preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                self.dismiss(animated: true)
                self.loginVC?.loginView.login.text = login
                self.loginVC?.loginView.password.text = password
                self.loginVC?.authWithRealm()
            }))
            self.present(alertVC, animated: true)
        }
        
//        loginButton.onTap = {
//            (self.delegate as? LoginInspector)?.checker.error = nil
//            guard let login = self.login.text, let password = self.password.text else { return }
//            self.delegate?.register(login: login, password: password)
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                if let error = (self.delegate as? LoginInspector)?.checker.error {
//                    self.coordinator?.showLoginAlertModule(message: error.localizedDescription, viewController: self)
//                } else {
//                    let alertVC = UIAlertController(title: "Отлично", message: "Регистрация прошла успешно.", preferredStyle: .alert)
//                    alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
//                        self.dismiss(animated: true)
//                    }))
//                    self.present(alertVC, animated: true)
//                }
//            }
//        }
    }
    
}

// MARK: - Constraints

extension RegisterViewController {
    private func setConstraints() {
        let constr = [
        
            loginPasswordView.topAnchor.constraint(equalTo: view.topAnchor, constant: 170),
            loginPasswordView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            loginPasswordView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            loginPasswordView.heightAnchor.constraint(equalToConstant: 100),
            
            loginButton.topAnchor.constraint(equalTo: loginPasswordView.bottomAnchor, constant: 16),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
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
            password.heightAnchor.constraint(equalToConstant: 50)
            
        ]
        NSLayoutConstraint.activate(constr)
    }
}
