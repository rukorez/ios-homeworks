//
//  FeedViewController.swift
//  Navigation
//
//  Created by Филипп Степанов on 01.08.2021.
//

import UIKit

class FeedViewController: UIViewController {

    var post1 = Post(title: "Пост 1")
    
    var button1:UIButton = {
        let button = UIButton()
        button.setTitle("Кнопка 1", for: .normal)
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return button
    }()
    
    var button2: UIButton = {
        let button = UIButton()
        button.setTitle("Кнопка 2", for: .normal)
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Лента"
        self.view.backgroundColor = .systemBlue
        
        let stackView = UIStackView(arrangedSubviews: [
            self.button1,
            self.button2
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
    
    @objc func tap() {
        let postVC = PostViewController()
        postVC.title = post1.title
        navigationController?.pushViewController(postVC, animated: true)
    }
}
