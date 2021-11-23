//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Филипп Степанов on 26.08.2021.
//

import UIKit

class ProfileHeaderView: UIView {
    
    var avatarImageView: UIImageView = {
        let avatar = UIImageView()
        avatar.image = UIImage(named: "Ava")
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.isUserInteractionEnabled = true
        avatar.layer.borderWidth = CGFloat(3)
        avatar.layer.masksToBounds = false
        avatar.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 10)
        avatar.clipsToBounds = true
        return avatar
    }()
    
    lazy var fullNameLabel: UILabel = {
        let name = UILabel()
        name.text = "Alco Dog"
        name.textColor = .black
        name.font = UIFont.boldSystemFont(ofSize: 18)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    lazy var statusLabel: UITextView = {
        let status = UITextView()
        status.text = "Waiting for drink..."
        status.textColor = .gray
        status.font = status.font?.withSize(14)
        status.backgroundColor = .lightGray
        status.translatesAutoresizingMaskIntoConstraints = false
        return status
    }()
    
    lazy var statusTextField: UITextField = {
        let statusEdit = UITextField()
        statusEdit.backgroundColor = .white
        statusEdit.textColor = .black
        statusEdit.font = statusEdit.font?.withSize(15)
        statusEdit.addTarget(self, action: #selector(statusTextChanged(_:)), for: .editingChanged)
        statusEdit.translatesAutoresizingMaskIntoConstraints = false
        statusEdit.layer.borderWidth = CGFloat(1)
        statusEdit.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 10)
        statusEdit.layer.cornerRadius = 10
        return statusEdit
    }()
    
    lazy var setStatusButton: UIButton = {
        let statusButton = UIButton()
        statusButton.backgroundColor = .systemBlue
        statusButton.setTitle("Show Status", for: .normal)
        statusButton.setTitleColor(UIColor.white, for: .normal)
        statusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        statusButton.translatesAutoresizingMaskIntoConstraints = false
        statusButton.layer.cornerRadius = 10
        statusButton.layer.shadowOffset.width = 4
        statusButton.layer.shadowOffset.height = 4
        statusButton.layer.shadowRadius = 4
        statusButton.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 10)
        statusButton.layer.shadowOpacity = 0.7
        return statusButton
    }()
    
    private var statusText: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(fullNameLabel)
        self.addSubview(statusLabel)
        self.addSubview(statusTextField)
        self.addSubview(setStatusButton)
        self.addSubview(avatarImageView)
        self.hideKeyboard()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.avatarImageView.layer.cornerRadius = avatarImageView.frame.size.height / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Скрытие клавиатуры по нажатию на UIView

extension ProfileHeaderView {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))

        self.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
}


// MARK: Кнопки

extension ProfileHeaderView {
    @objc func buttonPressed() {
        self.statusLabel.text = self.statusText
        if let currentStatus = self.statusLabel.text {
            print(currentStatus)
        }
        self.dismissKeyboard()
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        self.statusText = textField.text
    }
}

// MARK: Констрейнты

extension ProfileHeaderView {
    func setConstraintsPHV() {
        let constraintsPHV = [
            self.avatarImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.avatarImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            self.avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            self.avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            
            self.fullNameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 22),
            self.fullNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 50),
            self.fullNameLabel.widthAnchor.constraint(equalToConstant: 200),
            self.fullNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            self.statusLabel.topAnchor.constraint(equalTo: self.fullNameLabel.bottomAnchor, constant: 10),
            self.statusLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 50),
            self.statusLabel.widthAnchor.constraint(equalToConstant: 200),
            self.statusLabel.heightAnchor.constraint(equalToConstant: 25),
            
            self.statusLabel.topAnchor.constraint(equalTo: self.fullNameLabel.bottomAnchor, constant: 10),
            self.statusLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 50),
            self.statusLabel.widthAnchor.constraint(equalToConstant: 200),
            self.statusLabel.heightAnchor.constraint(equalToConstant: 25),
            
            self.statusTextField.topAnchor.constraint(equalTo: self.statusLabel.bottomAnchor, constant: 5),
            self.statusTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 50),
            self.statusTextField.widthAnchor.constraint(equalToConstant: 200),
            self.statusTextField.heightAnchor.constraint(equalToConstant: 40),
            
            self.setStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.setStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.setStatusButton.topAnchor.constraint(equalTo: self.avatarImageView.bottomAnchor, constant: 16),
            self.setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            self.setStatusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12)
        ]
        NSLayoutConstraint.activate(constraintsPHV)
    }
}
