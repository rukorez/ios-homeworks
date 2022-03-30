//
//  FeedViewController.swift
//  Navigation
//
//  Created by Филипп Степанов on 01.08.2021.
//

import UIKit
import StorageDevice

class FeedViewController: UIViewController {

    var post1 = Post(title: "Пост 1")
    
    lazy var button1: CustomButton = {
        let button = CustomButton(title: "Кнопка 1", titleColor: .black, backgroundColor: .clear)
        return button
    }()
    
    lazy var button2: CustomButton = {
        let button = CustomButton(title: "Кнопка 2", titleColor: .white, backgroundColor: .clear)
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
        return button
    }()
    
    lazy var passwordStatus: UILabel = {
        var label = UILabel()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Лента"
        self.view.backgroundColor = .systemBlue
        
        setStackView()
                
        button1.onTap = {
            self.tap()
        }
        button2.onTap = {
            self.tap()
        }
        
        customButton.onTap = {
            let model = Model()
            model.check(word: self.customTextField.text)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(correctPass), name: NSNotification.Name(rawValue: "correct password"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(incorrectPass), name: NSNotification.Name(rawValue: "incorrect password"), object: nil)
        
    }
    
    @objc func correctPass() {
        passwordStatus.text = "Correct Password!"
        passwordStatus.textColor = .systemGreen
    }
    
    @objc func incorrectPass() {
        passwordStatus.text = "Password wrong"
        passwordStatus.textColor = .systemRed
    }

    
    private func tap() {
        let postVC = PostViewController()
        postVC.title = post1.title
        navigationController?.pushViewController(postVC, animated: true)
    }
    
    private func setStackView() {
        let stackView = UIStackView(arrangedSubviews: [
            self.button1,
            self.button2,
            customTextField,
            customButton,
            passwordStatus
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        self.view.addSubview(stackView)
        let constraintsFVC = [
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraintsFVC)
    }
}
