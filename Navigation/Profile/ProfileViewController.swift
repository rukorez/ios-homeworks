//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Филипп Степанов on 01.08.2021.
//

import UIKit

class ProfileViewController: UIViewController {

    var profileView = ProfileHeaderView()
    
    var button: UIButton = {
        let button = UIButton()
        button.setTitle("Press Me!", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        self.title = "Профиль"
        self.view.backgroundColor = .lightGray

        self.view.addSubview(self.profileView)
        self.view.addSubview(self.button)
        self.profileView.setConstraintsPHV()
        self.profileView.translatesAutoresizingMaskIntoConstraints = false
        self.setConstraintsPVC()
        self.hideKeyboard()
        
        super.viewDidLoad()
    }
    
}

// MARK: Констрейнты

extension ProfileViewController {
    func setConstraintsPVC() {
        let constraintsPVC = [
        self.profileView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
        self.profileView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        self.profileView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
        self.profileView.heightAnchor.constraint(equalToConstant: 220),
        
        self.button.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
        self.button.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        self.button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraintsPVC)
    }
}
