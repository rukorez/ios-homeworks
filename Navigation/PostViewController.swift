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
        // Do any additional setup after loading the view.
    }
    
    @objc func tap() {
        let infoVC = InfoViewController()
        infoVC.view.backgroundColor = .systemGray
        infoVC.modalPresentationStyle = .automatic
        self.present(infoVC, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
