//
//  LogInViewController.swift
//  Navigation
//
//  Created by Филипп Степанов on 06.09.2021.
//

import UIKit

class LogInViewController: UIViewController {
        
    var scrollView = UIScrollView()
    var contentView = UIView()
    
    var delegate: LoginViewControllerDelegate?
    
    lazy var logo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var logInView: LogInView = {
        let loginview = LogInView()
        loginview.translatesAutoresizingMaskIntoConstraints = false
        loginview.layer.borderWidth = 0.5
        loginview.layer.borderColor = UIColor.lightGray.cgColor
        loginview.layer.cornerRadius = 10
        loginview.clipsToBounds = true
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
        self.view.backgroundColor = .white
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        loginButton.onTap = {
            self.loginTapped()
        }
        
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(logo)
        self.contentView.addSubview(logInView)
        self.contentView.addSubview(loginButton)
        
        self.logInView.login.delegate = self
        self.logInView.password.delegate = self
        self.hideKeyboard()
        self.setConstraints()
        
    }

}

// MARK: Констрейнты

extension LogInViewController {
    func setConstraints() {
        let constraints = [
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            
            self.logo.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.logo.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 120),
            self.logo.widthAnchor.constraint(equalToConstant: 100),
            self.logo.heightAnchor.constraint(equalTo: self.logo.widthAnchor),
            
            self.logInView.topAnchor.constraint(equalTo: self.logo.bottomAnchor, constant: 120),
            self.logInView.heightAnchor.constraint(equalToConstant: 100),
            self.logInView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.logInView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            
            self.loginButton.topAnchor.constraint(equalTo: self.logInView.bottomAnchor, constant: 16),
            self.loginButton.heightAnchor.constraint(equalToConstant: 50),
            self.loginButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.loginButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.loginButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
        ]
        NSLayoutConstraint.activate(constraints)
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
}

// MARK: Реализация функций кнопок

extension LogInViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    private func loginTapped() {
        guard let correctLogin = logInView.login.text?.hash else { return }
        guard let correctPassword = logInView.password.text?.hash else { return }
        guard let checkLogin = delegate?.checkLogin(login: correctLogin, password: correctPassword) else { return }
        if checkLogin {
            #if DEBUG
            let profileVC = ProfileViewController(userService: testUser, name: testUser.user.fullName!)
            self.navigationController?.pushViewController(profileVC, animated: true)
            #else
            let profileVC = ProfileViewController(userService: currentUser, name: currentUser.user.fullName!)
            self.navigationController?.pushViewController(profileVC, animated: true)
            #endif
        }
    }
}

// MARK: Расширение UIiewController для скрытия клавиатуры по нажатию вне поля TextField

extension UIViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))

        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: Делегирование UITextField для скрытия клавиатуры по нажатию кнопки return

extension UIViewController: UITextFieldDelegate{
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: Расширение для настройки alpha у UIImage

extension UIImage {
    func copy(alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
