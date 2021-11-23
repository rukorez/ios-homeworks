//
//  ProfileTableHeaderView.swift
//  Navigation
//
//  Created by Филипп Степанов on 12.09.2021.
//

import UIKit

class ProfileTableHeaderView: UIView {

    var profileView = ProfileHeaderView()
        
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .lightGray

        self.addSubview(self.profileView)
        self.profileView.setConstraintsPHV()
        self.profileView.translatesAutoresizingMaskIntoConstraints = false
        self.setConstraintsPTHV()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: Констрейнты

extension ProfileTableHeaderView {
    func setConstraintsPTHV() {
        let constraintsPTHV = [
            self.profileView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.profileView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.profileView.topAnchor.constraint(equalTo: self.topAnchor),
            self.profileView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraintsPTHV)
    }
}
