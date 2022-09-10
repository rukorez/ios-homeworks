//
//  LogInViewController.swift
//  Navigation
//
//  Created by Филипп Степанов on 06.09.2021.
//

import UIKit
import FirebaseAuth
import RealmSwift

final class LogInViewController: UIViewController {
    
    weak var coordinator: ProfileCoordinator?
    
    var loginView = LogInView()
    
    var delegate: LoginViewControllerDelegate?
    
    var bruteForce = BruteForce()
    
    let model = RealmUserModel()
    
    var currentUser: CurrentUserService = {
        var user = CurrentUserService()
        user.user.fullName = "Ivan Ivanov"
        user.user.avatar = UIImage(systemName: "person.fill")
        user.user.status = "Offline"
        return user
    }()
    
    var testUser = TestUserService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setDelegatesForViews()
        hideKeyboardInViewController()
        setTargetButton()
        authWithRealm()
    }
    
    private func setView() {
        self.view = loginView
    }
    
    private func setDelegatesForViews() {
        loginView.login.delegate = self
        loginView.password.delegate = self
    }
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.loginTapped()
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if loginView.login.text == "" && loginView.password.text == "" {
            loginView.loginButton.isEnabled = false
        } else {
            loginView.loginButton.isEnabled = true
        }
    }

}

// MARK: Вызов клавиатуры

extension LogInViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            loginView.scrollView.contentInset.bottom = keyboardSize.height
            loginView.scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        loginView.scrollView.contentInset.bottom = .zero
        loginView.scrollView.verticalScrollIndicatorInsets = .zero
    }
}

// MARK: Реализация функций кнопок

extension LogInViewController {
    
    private func setTargetButton() {
        loginView.secretButton.onTap = {
            if self.loginView.generateButton.isHidden {
                self.loginView.generateButton.isHidden = false
            } else {
                self.loginView.generateButton.isHidden = true
            }
        }
        
        loginView.registerButton.onTap = {
            self.coordinator?.showRegisterModule(controller: self)
        }
        
        loginView.loginButton.onTap = self.loginTapped
        loginView.generateButton.onTap = { [ weak self ] in
            self?.loginView.activityIndicator.startAnimating()
            
            let queue = DispatchQueue(label: "secondQueue", qos: .userInitiated)
            
            let workItem = DispatchWorkItem {
                self?.bruteForce.bruteForce(passwordToUnlock: LoginChecker.shared.password)
            }
            
            queue.async(execute: workItem)
            
            workItem.notify(queue: DispatchQueue.main) {
                self?.loginView.activityIndicator.stopAnimating()
                self?.loginView.password.isSecureTextEntry = false
                self?.loginView.password.text = self?.bruteForce.password
            }
        }
    }
    
    private func loginTapped() {
//        guard let correctLogin = loginView.login.text?.hash,
//              let correctPassword = loginView.password.text?.hash,
//              let checkLogin = delegate?.checkLogin(login: correctLogin, password: correctPassword)
//        else { return }
//        if checkLogin.0 {
//            #if DEBUG
//            coordinator?.showProfileModule(userService: testUser, name: testUser.user.fullName ?? "")
//            #else
//            coordinator?.showProfileModule(userService: currentUser, name: currentUser.user.fullName ?? "")
//            #endif
//        } else {
//            guard let message = checkLogin.1 else { return }
//            coordinator?.showLoginAlertModule(message: message, viewController: self)
//        }
        
//        authWithFireBase()
        
        authWithRealm()
    }
    
    func authWithRealm() {
        
        if !model.users.isEmpty {
#if DEBUG
            self.coordinator?.showProfileModule(userService: self.testUser, name: self.testUser.user.fullName ?? "")
#else
            self.coordinator?.showProfileModule(userService: self.currentUser, name: self.currentUser.user.fullName ?? "")
#endif
        } else {
            guard let login = loginView.login.text, login != "",
                  let password = loginView.password.text, password != "" else { return }
            if !model.checkUser(login: login) {
                let alert = UIAlertController(title: "Пройдите регистрацию", message: "", preferredStyle: .alert)
                let alertOK = UIAlertAction(title: "OK", style: .default)
                alert.addAction(alertOK)
                present(alert, animated: true)
            } else {
#if DEBUG
            self.coordinator?.showProfileModule(userService: self.testUser, name: self.testUser.user.fullName ?? "")
#else
            self.coordinator?.showProfileModule(userService: self.currentUser, name: self.currentUser.user.fullName ?? "")
#endif
            }
        }
    }
    
    func authWithFireBase() {
        guard let loginInspector = (delegate as? LoginInspector) else { return }
        loginInspector.checker.error = nil
        loginInspector.checker.isRegister = false
        guard let login = loginView.login.text,
              let password = loginView.password.text else { return }
        guard let check = delegate?.checkLogin(login: login, password: password) else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if loginInspector.checker.isRegister {
                print(check)
#if DEBUG
                self.coordinator?.showProfileModule(userService: self.testUser, name: self.testUser.user.fullName ?? "")
#else
                self.coordinator?.showProfileModule(userService: self.currentUser, name: self.currentUser.user.fullName ?? "")
#endif
            } else {
                guard let message = loginInspector.checker.error?.localizedDescription else { return }
                self.coordinator?.showLoginAlertModule(message: message, viewController: self)
            }
        }
        
    }
}
