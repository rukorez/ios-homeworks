//
//  FeedViewController.swift
//  Navigation
//
//  Created by Филипп Степанов on 01.08.2021.
//

import UIKit

class FeedViewController: UIViewController {

    var post1 = Post(title: "Пост 1")

        override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Лента"
        self.view.backgroundColor = .systemBlue
                
        let button = UIButton(frame: CGRect(x: 100, y: 200, width: 200, height: 50))
        button.setTitle(post1.title, for: .normal)
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func tap() {
        let postVC = PostViewController()
        postVC.title = post1.title
        navigationController?.pushViewController(postVC, animated: true)
    }
}
