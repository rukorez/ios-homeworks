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
        avatar.isUserInteractionEnabled = true
        avatar.clipsToBounds = true
        return avatar
    }()
    
    lazy var fullNameLabel: UILabel = {
        let name = UILabel()
        name.text = "Happy Dog"
        name.textColor = .black
        name.font = UIFont.boldSystemFont(ofSize: 20)
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
        return status
    }()
    
    lazy var statusTextField: CustomTextField = {
        let statusEdit = CustomTextField(insets: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12))
        statusEdit.backgroundColor = .white
        statusEdit.textColor = .black
        statusEdit.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return statusEdit
    }()
    
    lazy var setStatusButton: CustomButton = {
        let statusButton = CustomButton(title: "Show Status", titleColor: .white, backgroundColor: .systemBlue)
        return statusButton
    }()
        
    var statusText: String?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setViews()
        hideKeyBoardInView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        avatarLayout()
        fullNameLabelLayout()
        statusLabelLayout()
        statusTextFieldLayout()
        setStatusButtonLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViews() {
        contentView.addSubview(fullNameLabel)
        contentView.addSubview(statusLabel)
        contentView.addSubview(statusTextField)
        contentView.addSubview(setStatusButton)
        contentView.addSubview(avatarImageView)
    }
    
    private func avatarLayout() {
        avatarImageView.frame = CGRect(x: 16, y: 16, width: 110, height: 110)
        avatarImageView.layer.borderWidth = CGFloat(3)
        avatarImageView.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 10)
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height / 2
    }
    
    private func fullNameLabelLayout() {
        fullNameLabel.frame = CGRect(x: 16 + avatarImageView.bounds.width + 20, y: 16, width: contentView.bounds.width - 36 - avatarImageView.bounds.width, height: 30)
    }
    
    private func statusLabelLayout() {
        statusLabel.frame = CGRect(x: 16 + avatarImageView.bounds.height + 17, y: 16 + fullNameLabel.bounds.height + 6, width: contentView.bounds.width - 36 - avatarImageView.bounds.width, height: 30)
    }
    
    private func statusTextFieldLayout() {
        statusTextField.frame = CGRect(x: 16 + avatarImageView.bounds.height + 17,
                                       y: 16 + fullNameLabel.bounds.height + 6 + statusLabel.bounds.height + 10,
                                       width: contentView.bounds.width - 52 - avatarImageView.bounds.width, height: 30)
        statusTextField.layer.borderWidth = CGFloat(1)
        statusTextField.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 10)
        statusTextField.layer.cornerRadius = 10
    }
    
    private func setStatusButtonLayout() {
        setStatusButton.frame = CGRect(x: 16, y: 16 + avatarImageView.bounds.height + 16, width: contentView.bounds.width - 32, height: 40)
        setStatusButton.layer.cornerRadius = 10
        setStatusButton.layer.shadowOffset.width = 4
        setStatusButton.layer.shadowOffset.height = 4
        setStatusButton.layer.shadowRadius = 4
        setStatusButton.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 10)
        setStatusButton.layer.shadowOpacity = 0.7
    }
}
