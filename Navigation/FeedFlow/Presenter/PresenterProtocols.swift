//
//  PresenterProtocol.swift
//  Navigation
//
//  Created by Филипп Степанов on 13.05.2022.
//

import Foundation

protocol PresenterControllerInput: AnyObject {
    func updateData(data: Bool)
    func showNextModule(goTo: @escaping ()->Void)
}

protocol PresenterControllerOutput: AnyObject {
    func passData(data: String?)
}
