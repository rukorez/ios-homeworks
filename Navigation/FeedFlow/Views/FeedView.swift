//
//  FeedView.swift
//  Navigation
//
//  Created by Филипп Степанов on 13.05.2022.
//

import Foundation
import UIKit

final class FeedView: UIView {
    
    var tapCheckPass: ((String?)->Void)?
    
    lazy var button1: CustomButton = {
        var button = CustomButton(title: "Кнопка 1", titleColor: .black, backgroundColor: .clear)
        return button
    }()
    
    lazy var button2: CustomButton = {
        var button = CustomButton(title: "Кнопка 2", titleColor: .white, backgroundColor: .clear)
        return button
    }()
    
    lazy var customTextField: CustomTextField = {
        var textField = CustomTextField(insets: UIEdgeInsets(top: 3, left: 12, bottom: 3, right: 12))
        textField.backgroundColor = .white
        textField.textAlignment = .center
        return textField
    }()
    
    lazy var customButton: CustomButton = {
        var button = CustomButton(title: "Check password", titleColor: .black, backgroundColor: .clear)
        button.onTap = {
            self.tapCheckPass?(self.customTextField.text)
        }
        return button
    }()
    
    lazy var passwordStatus = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func checkPassword(correct: Bool) {
        switch correct {
        case true:
            passwordStatus.text = "Correct Password!"
            passwordStatus.textColor = .systemGreen
        case false:
            passwordStatus.text = "Password wrong"
            passwordStatus.textColor = .systemRed
        }
    }
    
    private func setViews() {
        backgroundColor = .systemBlue
        let stackView = UIStackView(arrangedSubviews: [
            button1,
            button2,
            customTextField,
            customButton,
            passwordStatus
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        addSubview(stackView)
        let constraintsFVC = [
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraintsFVC)
    }
    
}
