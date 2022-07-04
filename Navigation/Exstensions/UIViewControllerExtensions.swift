//
//  UIViewControllerExtensions.swift
//  Navigation
//
//  Created by Филипп Степанов on 04.07.2022.
//

import Foundation
import UIKit


// MARK: Делегирование UITextField для скрытия клавиатуры по нажатию кнопки return

extension UIViewController: UITextFieldDelegate{
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: Расширение UIiewController для скрытия клавиатуры по нажатию вне поля TextField

extension UIViewController {
    func hideKeyboardInViewController() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))

        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
