//
//  PostViewController.swift
//  Navigation
//
//  Created by Филипп Степанов on 02.08.2021.
//

import UIKit

final class PostViewController: UIViewController {
    
    weak var coordinator: FeedCoordinator?
    
    private var durationTimer = 5
    private var timer = Timer()
    
    lazy var timerLabel: UILabel = {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 100))
        label.text = ""
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        durationTimer = 5
    }
    
    private func setView() {
        view.backgroundColor = .cyan
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Информация", style: .done, target: self, action: #selector(tap))
        view.addSubview(timerLabel)
        timerLabel.center = view.center
    }
    
    @objc private func tap() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func startTimer() {
        timerLabel.text = "\(durationTimer)"
        durationTimer -= 1
        if durationTimer == -1 {
            timer.invalidate()
            timerLabel.isHidden = true
            coordinator?.showInfoModule(controller: self)
        }
    }
    
}
