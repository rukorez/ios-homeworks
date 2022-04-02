//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Филипп Степанов on 26.08.2021.
//
import SnapKit
import UIKit

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    lazy var avatarImageView: UIImageView = {
        let avatar = UIImageView()
        avatar.image = UIImage(named: "Ava")
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(animation))
//        avatar.addGestureRecognizer(gesture)
//        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.isUserInteractionEnabled = true
        avatar.clipsToBounds = true
        return avatar
    }()
    
    lazy var whiteView: UIView = {
        var whiteView = UIView(frame: CGRect(x: 0, y: 0, width: UIWindow().bounds.width, height: UIWindow().bounds.height))
        whiteView.backgroundColor = UIColor(white: 1, alpha: 0)
        return whiteView
    }()
    
    
    lazy var closeButton: UIButton = {
        var button = UIButton(frame: CGRect(x: UIWindow().bounds.width - 40, y: 40, width: 30, height: 30))
        button.setBackgroundImage(UIImage(systemName: "multiply"), for: .normal)
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        return button
    }()
    
    lazy var fullNameLabel: UILabel = {
        let name = UILabel()
        name.text = "Happy Dog"
        name.textColor = .black
        name.font = UIFont.boldSystemFont(ofSize: 20)
//        name.translatesAutoresizingMaskIntoConstraints = false
        name.numberOfLines = 1
        return name
    }()
    
    lazy var statusLabel: UITextView = {
        let status = UITextView()
        status.text = "Waiting for something..."
        status.font = UIFont.italicSystemFont(ofSize: 15)
        status.isScrollEnabled = false
        status.isEditable = false
        status.backgroundColor = .clear
        #if DEBUG
        status.textColor = .gray
        #else
        status.textColor = .white
        #endif
//        status.translatesAutoresizingMaskIntoConstraints = false
        return status
    }()
    
    lazy var statusTextField: CustomTextField = {
        let statusEdit = CustomTextField(insets: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12))
        statusEdit.backgroundColor = .white
        statusEdit.textColor = .black
        statusEdit.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        statusEdit.addTarget(self, action: #selector(statusTextChanged(_:)), for: .editingChanged)
//        statusEdit.translatesAutoresizingMaskIntoConstraints = false
        return statusEdit
    }()
    
    lazy var setStatusButton: CustomButton = {
        let statusButton = CustomButton(title: "Show Status", titleColor: .white, backgroundColor: .systemBlue)
//        statusButton.translatesAutoresizingMaskIntoConstraints = false
        return statusButton
    }()
        
    private var statusText: String?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(fullNameLabel)
        contentView.addSubview(statusLabel)
        contentView.addSubview(statusTextField)
        contentView.addSubview(setStatusButton)
        contentView.addSubview(avatarImageView)
        setStatusButton.onTap = {
            self.buttonPressed()
        }
//        setConstraintsPHV()
        hideKeyboard()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        avatarImageView.frame = CGRect(x: 16, y: 16, width: 110, height: 110)
        fullNameLabel.frame = CGRect(x: 16 + avatarImageView.bounds.width + 20, y: 16, width: contentView.bounds.width - 36 - avatarImageView.bounds.width, height: 30)
        statusLabel.frame = CGRect(x: 16 + avatarImageView.bounds.height + 17, y: 16 + fullNameLabel.bounds.height + 6, width: contentView.bounds.width - 36 - avatarImageView.bounds.width, height: 30)
        statusTextField.frame = CGRect(x: 16 + avatarImageView.bounds.height + 17,
                                       y: 16 + fullNameLabel.bounds.height + 6 + statusLabel.bounds.height + 10,
                                       width: contentView.bounds.width - 52 - avatarImageView.bounds.width, height: 30)
        setStatusButton.frame = CGRect(x: 16, y: 16 + avatarImageView.bounds.height + 16, width: contentView.bounds.width - 32, height: 40)
        
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
    
    @objc func animation() {
        contentView.addSubview(whiteView)
        contentView.bringSubviewToFront(avatarImageView)
        self.avatarImageView.layer.borderWidth = 0
        UIView.animate(withDuration: 1.0, delay: 0) {
            self.avatarImageView.frame = CGRect(x: 0, y: 0, width: UIWindow().bounds.width, height: UIWindow().bounds.width)
            self.avatarImageView.center = UIWindow().center
            self.whiteView.backgroundColor = UIColor(white: 1, alpha: 0.8)
        } completion: { _ in
            self.avatarImageView.clipsToBounds = false
            self.whiteView.addSubview(self.closeButton)
        }
    }
    
    @objc func close() {
        UIView.animate(withDuration: 1.0, delay: 0) {
            self.avatarImageView.frame = CGRect(x: 16, y: 16, width: 110, height: 110)
            self.avatarImageView.layer.borderWidth = CGFloat(3)
            self.avatarImageView.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 10)
            self.avatarImageView.layer.cornerRadius = self.avatarImageView.bounds.height / 2
            self.avatarImageView.clipsToBounds = true
            self.whiteView.backgroundColor = UIColor(white: 1, alpha: 0)
        }
        contentView.sendSubviewToBack(whiteView)
        closeButton.removeFromSuperview()
//        layoutIfNeeded()
        print("Close")
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
    private func buttonPressed() {
        statusLabel.text = statusText
        dismissKeyboard()
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text
    }
    
}

// MARK: Констрейнты
//extension ProfileHeaderView {
//
//    func setConstraintsPHV() {
//
//        avatarImageView.snp.makeConstraints { (maker) in
//            maker.leading.top.equalToSuperview().offset(16)
//            maker.bottom.equalToSuperview().offset(-16)
//            maker.width.height.equalTo(110)
//        }
//
//        fullNameLabel.snp.makeConstraints { (maker) in
//            maker.top.equalToSuperview().offset(16)
//            maker.leading.equalTo(avatarImageView.snp.trailing).offset(20)
//            maker.trailing.equalToSuperview().offset(-16)
//        }
//
//        statusLabel.snp.makeConstraints { (maker) in
//            maker.top.equalTo(fullNameLabel.snp.bottom).offset(6)
//            maker.leading.equalTo(avatarImageView.snp.trailing).offset(17)
//            maker.trailing.equalToSuperview().offset(-16)
//
//        }
//
//        statusTextField.snp.makeConstraints { (maker) in
//            maker.top.equalTo(statusLabel.snp.bottom).offset(10)
//            maker.leading.equalTo(avatarImageView.snp.trailing).offset(20)
//            maker.trailing.equalToSuperview().offset(-16)
//            maker.bottom.equalTo(avatarImageView.snp.bottom)
//            maker.height.equalTo(30)
//        }
//
//        setStatusButton.snp.makeConstraints { (maker) in
////            maker.top.equalTo(myView.snp.bottom)
//            maker.leading.equalToSuperview().offset(16)
//            maker.trailing.equalToSuperview().offset(-16)
//            maker.bottom.equalToSuperview().offset(-20)
//            maker.height.equalTo(40)
//        }
//
//        layoutIfNeeded()
//
//    }
//
//}
