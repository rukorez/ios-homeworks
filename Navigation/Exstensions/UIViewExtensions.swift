//
//  UIViewExtensions.swift
//  Navigation
//
//  Created by Филипп Степанов on 04.07.2022.
//

import Foundation
import UIKit

// MARK: Расширение UIView для скрытия клавиатуры по нажатию вне поля TextField

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
