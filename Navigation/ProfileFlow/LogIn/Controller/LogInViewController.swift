//
//  LogInViewController.swift
//  Navigation
//
//  Created by Филипп Степанов on 06.09.2021.
//

import UIKit

final class LogInViewController: UIViewController {
    
    weak var coordinator: ProfileCoordinator?
    
    var loginView = LogInView()
    
    var delegate: LoginViewControllerDelegate?
    
    var bruteForce = BruteForce()
    
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
        guard let correctLogin = loginView.login.text?.hash,
              let correctPassword = loginView.password.text?.hash,
              let checkLogin = delegate?.checkLogin(login: correctLogin, password: correctPassword)
        else { return }
        if checkLogin {
            #if DEBUG
            coordinator?.showProfileModule(userService: testUser, name: testUser.user.fullName ?? "")
            #else
            coordinator?.showProfileModule(userService: currentUser, name: currentUser.user.fullName ?? "")
            #endif
        }
    }
}
