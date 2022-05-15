//
//  FeedViewController.swift
//  Navigation
//
//  Created by Филипп Степанов on 01.08.2021.
//

import UIKit
import StorageDevice

final class FeedViewController: UIViewController {
    
    var output: PresenterControllerOutput

    var data: String?
    
    var feedView = FeedView()
    
    init(output: PresenterControllerOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        addTargetButton()
        hideKeyboardInViewController()
    }
    
    private func setViews() {
        self.view = feedView
        feedView.customTextField.delegate = self
    }
    
    func addTargetButton() {
        feedView.tapCheckPass = { password in
            self.output.passData(data: password)
        }
    }
    
    func correctPass(bool: Bool) {
        feedView.checkPassword(correct: bool)
    }
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        feedView.tapCheckPass?(feedView.customTextField.text)
        textField.resignFirstResponder()
        return true
    }

}

extension FeedViewController: PresenterControllerInput {
    
    func updateData(data: Bool) {
        self.correctPass(bool: data)
    }
    
    func showNextModule(goTo: @escaping ()->Void) {
        feedView.button1.onTap = goTo
        feedView.button2.onTap = goTo
    }
    
}
