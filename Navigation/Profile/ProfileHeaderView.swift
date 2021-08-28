//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Филипп Степанов on 26.08.2021.
//

import UIKit

class ProfileHeaderView: UIView {
    
    var avatar: UIImageView = {
        let avatar = UIImageView()
        avatar.image = UIImage(named: "Ava")
        avatar.layer.borderWidth = CGFloat(3)
        avatar.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 10)
        return avatar
    }()
    
    var name: UILabel = {
        let name = UILabel()
        name.text = "Alco Dog"
        name.textColor = .black
        name.font = UIFont.boldSystemFont(ofSize: 18)
        return name
    }()
    
    var status: UITextView = {
        let status = UITextView()
        status.text = "Waiting for drink..."
        status.textColor = .gray
        status.font = status.font?.withSize(14)
        status.backgroundColor = .lightGray
        return status
    }()
    
    var statusButton: UIButton = {
        let statusButton = UIButton()
        statusButton.backgroundColor = .systemBlue
        statusButton.setTitle("Show Status", for: .normal)
        statusButton.setTitleColor(UIColor.white, for: .normal)
        statusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return statusButton
    }()
    
    var statusEdit: UITextField = {
        let statusEdit = UITextField()
        statusEdit.backgroundColor = .white
        statusEdit.textColor = .black
        statusEdit.font = statusEdit.font?.withSize(15)
        statusEdit.layer.borderWidth = CGFloat(1)
        statusEdit.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 10)
        statusEdit.addTarget(self, action: #selector(statusTextChanged(_:)), for: .editingChanged)
        return statusEdit
    }()
    
    private var statusText: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(avatar)
        self.addSubview(name)
        self.addSubview(status)
        self.addSubview(statusButton)
        self.addSubview(statusEdit)
    }
    
    @objc func buttonPressed() {
        self.status.text = self.statusText
        if let currentStatus = self.status.text {
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
