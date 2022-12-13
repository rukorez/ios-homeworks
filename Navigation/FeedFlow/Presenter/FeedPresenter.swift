//
//  FeedPresenterController.swift
//  Navigation
//
//  Created by Филипп Степанов on 13.05.2022.
//

import Foundation

final class FeedPresenter: PresenterControllerOutput {
    
    weak var coordinator: FeedCoordinator?
    
    weak var input: PresenterControllerInput?
    
    var post1: Post = Post(title: NSLocalizedString("feedViewPostTitle", comment: ""))
    
    init() {
        notifications()
    }
    
    func sendData() {
        input?.showNextModule(goTo: { [ weak self ] in
            self?.coordinator?.showPostModule(title: self?.post1.title ?? "")
        })
    }
    
    func passData(data: String?) {
        checkPassword(password: data)
    }
    
    private func checkPassword(password: String?) {
        guard let password = password else { return }
        let model = Model()
        model.check(word: password)
    }
    
    func notifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(correctPass), name: NSNotification.Name(rawValue: "correct password"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(incorrectPass), name: NSNotification.Name(rawValue: "incorrect password"), object: nil)
    }
    
    @objc private func correctPass() {
        input?.updateData(data: true)
    }
    
    @objc private func incorrectPass() {
        input?.updateData(data: false)
    }
}
