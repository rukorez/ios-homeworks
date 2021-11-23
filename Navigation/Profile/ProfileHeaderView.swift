//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Филипп Степанов on 26.08.2021.
//

import UIKit

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    lazy var avatarImageView: UIImageView = {
        let avatar = UIImageView()
        avatar.image = UIImage(named: "Ava")
//        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.isUserInteractionEnabled = true
        avatar.clipsToBounds = true
        return avatar
    }()
    
    lazy var fullNameLabel: UILabel = {
        let name = UILabel()
        name.text = "Happy Dog"
        name.textColor = .black
        name.font = UIFont.boldSystemFont(ofSize: 20)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.numberOfLines = 1
        return name
    }()
    
    lazy var statusLabel: UITextView = {
        let status = UITextView()
        status.text = "Waiting for something..."
        status.font = UIFont.italicSystemFont(ofSize: 15)
        status.isScrollEnabled = false
        #if DEBUG
        status.textColor = .gray
        status.backgroundColor = .systemGray5
        #else
        status.textColor = .white
        status.backgroundColor = UIColor(named: "VKBlue")
        #endif
        status.translatesAutoresizingMaskIntoConstraints = false
        return status
    }()
    
    lazy var statusTextField: CustomTextField = {
        let statusEdit = CustomTextField(insets: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12))
        statusEdit.backgroundColor = .white
        statusEdit.textColor = .black
        statusEdit.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        statusEdit.addTarget(self, action: #selector(statusTextChanged(_:)), for: .editingChanged)
        statusEdit.translatesAutoresizingMaskIntoConstraints = false
        return statusEdit
    }()
    
    lazy var setStatusButton: UIButton = {
        let statusButton = UIButton()
        statusButton.backgroundColor = .systemBlue
        statusButton.setTitle("Show Status", for: .normal)
        statusButton.setTitleColor(UIColor.white, for: .normal)
        statusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        statusButton.translatesAutoresizingMaskIntoConstraints = false
        return statusButton
    }()
        
    private var statusText: String?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(statusTextField)
        addSubview(setStatusButton)
        addSubview(avatarImageView)
        setConstraintsPHV()
        hideKeyboard()

    }
    
    override func layoutSubviews() {
        avatarImageView.frame = CGRect(x: 16, y: 10, width: 120, height: 120)
        avatarImageView.layer.borderWidth = CGFloat(3)
        avatarImageView.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 10)
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height / 2
        statusTextField.layer.borderWidth = CGFloat(1)
        statusTextField.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 10)
        statusTextField.layer.cornerRadius = 10
        setStatusButton.layer.cornerRadius = 10
        setStatusButton.layer.shadowOffset.width = 4
        setStatusButton.layer.shadowOffset.height = 4
        setStatusButton.layer.shadowRadius = 4
        setStatusButton.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 10)
        setStatusButton.layer.shadowOpacity = 0.7
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: Скрытие клавиатуры по нажатию на UIView
extension UIView {
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
        statusLabel.text = statusText
        dismissKeyboard()
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text
    }
    
}

// MARK: Констрейнты
extension ProfileHeaderView {
    func setConstraintsPHV() {
        
        fullNameLabel.setContentHuggingPriority(.required, for: .vertical)
        statusLabel.setContentHuggingPriority(.required, for: .vertical)
        statusTextField.setContentHuggingPriority(.required, for: .vertical)
        setStatusButton.setContentHuggingPriority(.required, for: .vertical)
        
        let constraintsPHV = [
            
            fullNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            fullNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 150),
            fullNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            fullNameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            statusLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 145),
            statusLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            statusLabel.heightAnchor.constraint(equalToConstant: 30),
            
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 15),
            statusTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 145),
            statusTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            statusTextField.heightAnchor.constraint(equalToConstant: 30),
                    
            setStatusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 20),
            setStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            setStatusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            
//            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
//            avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
//            avatarImageView.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -10),
//            avatarImageView.trailingAnchor.constraint(equalTo: statusTextField.leadingAnchor, constant: -15),
//            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor)
        ]
        NSLayoutConstraint.activate(constraintsPHV)
    }
}
