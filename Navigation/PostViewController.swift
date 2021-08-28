//
//  PostViewController.swift
//  Navigation
//
//  Created by Филипп Степанов on 02.08.2021.
//

import UIKit

class PostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .cyan
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Информация", style: .done, target: self, action: #selector(tap))
        
    }
    
    @objc func tap() {
        let infoVC = InfoViewController()
        infoVC.view.backgroundColor = .systemGray
        infoVC.modalPresentationStyle = .automatic
        self.present(infoVC, animated: true, completion: nil)
    }
    
}
