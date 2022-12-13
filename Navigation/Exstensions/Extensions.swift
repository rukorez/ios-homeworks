//
//  Extensions.swift
//  Navigation
//
//  Created by Филипп Степанов on 14.05.2022.
//

import UIKit

// MARK: Расширение UIView и UIiewController для скрытия клавиатуры по нажатию вне поля TextField

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

extension UIView {
    func hideKeyBoardInView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIView.dismissKeyboardInView))

        addGestureRecognizer(tap)
    }

    @objc func dismissKeyboardInView() {
        endEditing(true)
    }
}

// MARK: Делегирование UITextField для скрытия клавиатуры по нажатию кнопки return

extension UIViewController: UITextFieldDelegate{
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: Расширение для настройки alpha у UIImage

extension UIImage {
    func copy(alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
