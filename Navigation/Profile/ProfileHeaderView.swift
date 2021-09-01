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
        return avatar
    }()
    
    func avatarLayout() {
        
        [
            self.avatarImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.avatarImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            self.avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            self.avatarImageView.heightAnchor.constraint(equalToConstant: 100),
        ]
        .forEach {
            $0.isActive = true
        }
        
        self.avatarImageView.layer.borderWidth = CGFloat(3)
        self.avatarImageView.layer.masksToBounds = false
        self.avatarImageView.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 10)
        self.avatarImageView.layer.cornerRadius = 50
        self.avatarImageView.clipsToBounds = true
        
    }
    
    var fullNameLabel: UILabel = {
        let name = UILabel()
        name.text = "Alco Dog"
        name.textColor = .black
        name.font = UIFont.boldSystemFont(ofSize: 18)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    func fullNameLabelLayout() {
        [
            self.fullNameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 22),
            self.fullNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 50),
            self.fullNameLabel.widthAnchor.constraint(equalToConstant: 200),
            self.fullNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ]
        .forEach {
            $0.isActive = true
        }
    }
    
    var statusLabel: UITextView = {
        let status = UITextView()
        status.text = "Waiting for drink..."
        status.textColor = .gray
        status.font = status.font?.withSize(14)
        status.backgroundColor = .lightGray
        status.translatesAutoresizingMaskIntoConstraints = false
        return status
    }()
    
    func statusLabelLayout() {
        [
            self.statusLabel.topAnchor.constraint(equalTo: self.fullNameLabel.bottomAnchor, constant: 10),
            self.statusLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 50),
            self.statusLabel.widthAnchor.constraint(equalToConstant: 200),
            self.statusLabel.heightAnchor.constraint(equalToConstant: 25)
        ]
        .forEach {
            $0.isActive = true
        }
    }
    
    var statusTextField: UITextField = {
        let statusEdit = UITextField()
        statusEdit.backgroundColor = .white
        statusEdit.textColor = .black
        statusEdit.font = statusEdit.font?.withSize(15)
        statusEdit.addTarget(self, action: #selector(statusTextChanged(_:)), for: .editingChanged)
        statusEdit.translatesAutoresizingMaskIntoConstraints = false
        return statusEdit
    }()
    
    func statusTextFieldLayout() {
        [
            self.statusTextField.topAnchor.constraint(equalTo: self.statusLabel.bottomAnchor, constant: 5),
            self.statusTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 50),
            self.statusTextField.widthAnchor.constraint(equalToConstant: 200),
            self.statusTextField.heightAnchor.constraint(equalToConstant: 40)
        ]
        .forEach {
            $0.isActive = true
        }
        
        statusTextField.layer.borderWidth = CGFloat(1)
        statusTextField.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 10)
        statusTextField.layer.cornerRadius = 10
    }
    
    var setStatusButton: UIButton = {
        let statusButton = UIButton()
        statusButton.backgroundColor = .systemBlue
        statusButton.setTitle("Show Status", for: .normal)
        statusButton.setTitleColor(UIColor.white, for: .normal)
        statusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        statusButton.translatesAutoresizingMaskIntoConstraints = false
        return statusButton
    }()
    
    func setStatusButtonLayout() {
        [
            self.setStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.setStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.setStatusButton.topAnchor.constraint(equalTo: self.avatarImageView.bottomAnchor, constant: 16),
            self.setStatusButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        .forEach {
            $0.isActive = true
        }
        
        setStatusButton.layer.cornerRadius = 10
        setStatusButton.layer.shadowOffset.width = 4
        setStatusButton.layer.shadowOffset.height = 4
        setStatusButton.layer.shadowRadius = 4
        setStatusButton.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 10)
        setStatusButton.layer.shadowOpacity = 0.7
    }
    
    
    private var statusText: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(avatarImageView)
        self.addSubview(fullNameLabel)
        self.addSubview(statusLabel)
        self.addSubview(statusTextField)
        self.addSubview(setStatusButton)
    }
    
    @objc func buttonPressed() {
        self.statusLabel.text = self.statusText
        if let currentStatus = self.statusLabel.text {
            print(currentStatus)
        }
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        self.statusText = textField.text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
