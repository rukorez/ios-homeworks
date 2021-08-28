//
//  InfoViewController.swift
//  Navigation
//
//  Created by Филипп Степанов on 03.08.2021.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonDelete = UIButton(frame: CGRect(x: 100, y: 350, width: 200, height: 50))
        buttonDelete.setTitle("Удалить все", for: .normal)
        buttonDelete.addTarget(self, action: #selector(tap), for: .touchUpInside)
        view.addSubview(buttonDelete)

    }
    
    @objc func tap() {
        let alertVC = UIAlertController(title: "Удаление", message: "Удалить всю информацию?", preferredStyle: .alert)
        let actionYes = UIAlertAction(title: "Да", style: .default) { _ in print ("Да")}
        alertVC.addAction(actionYes)
        let actionNo = UIAlertAction(title: "Нет", style: .default) { _ in print("Нет")}
        alertVC.addAction(actionNo)
        self.present(alertVC, animated: true, completion: nil)
    }


}
