//
//  PlayerViewController.swift
//  Navigation
//
//  Created by Филипп Степанов on 07.08.2022.
//

import Foundation
import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    
    var coordinator: Coordinator?
    
    var Player = AVAudioPlayer()
    
    var position:Int = 0
    var songs: [String] = ["Queen", "Memories", "TNT", "I need a dollar", "Pump It"]
    
    var songName: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    
    var playButton: UIButton = {
        var button = UIButton()
        button.addTarget(self, action: #selector(play), for: .touchUpInside)
        button.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        return button
    }()
    
    var pauseButton: UIButton = {
        var button = UIButton()
        button.addTarget(self, action: #selector(pause), for: .touchUpInside)
        button.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        return button
    }()
    
    var stopButton: UIButton = {
        var button = UIButton()
        button.addTarget(self, action: #selector(stop), for: .touchUpInside)
        button.setBackgroundImage(UIImage(systemName: "stop.fill"), for: .normal)
        return button
    }()
    
    var nextButton: UIButton = {
        var button = UIButton()
        button.addTarget(self, action: #selector(nextSong), for: .touchUpInside)
        button.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)
        return button
    }()
    
    var backButton: UIButton = {
        var button = UIButton()
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        button.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        createPlayer()
    }
    
    func createPlayer() {
        let song = songs[position]
        do {
            Player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: song, ofType: "mp3")!))
            Player.prepareToPlay()
            songName.text = song
        }
        catch {
            print(error)
        }
    }
    
    private func setLayout() {
        view.addSubview(songName)
        view.addSubview(playButton)
        view.addSubview(pauseButton)
        view.addSubview(stopButton)
        view.addSubview(backButton)
        view.addSubview(nextButton)
        view.backgroundColor = .white
        songName.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        songName.center = view.center
        playButton.frame = CGRect(x: 100, y: 600, width: 30, height: 30)
        pauseButton.frame = CGRect(x: 100 + playButton.bounds.width + 75, y: 600, width: 30, height: 30)
        stopButton.frame = CGRect(x: 100 + playButton.bounds.width + 75 + pauseButton.bounds.width + 75,
                                  y: 600, width: 30, height: 30)
        backButton.frame = CGRect(x: 150, y: 600 + playButton.bounds.height + 20, width: 30, height: 30)
        nextButton.frame = CGRect(x: 150 + backButton.bounds.width + 80,
                                  y: 600 + playButton.bounds.height + 20, width: 30, height: 30)
    }
    
    
}

// MARK: Функционал кнопок

extension PlayerViewController {
    
    @objc private func play(_ sender: UIButton) {
        Player.play()
    }
    
    @objc private func pause(_ sender: UIButton) {
        if Player.isPlaying {
            Player.pause()
        }
    }
    
    @objc private func stop(_ sender: UIButton) {
        if Player.isPlaying {
            Player.stop()
            Player.currentTime = 0
        }
    }
    
    @objc private func nextSong(_ sender: UIButton) {
        if position < (songs.count - 1) {
            position += 1
            Player.stop()
            createPlayer()
        }
        Player.play()
    }
    
    @objc private func back(_ sender: UIButton) {
        if position > 0 {
            position -= 1
            Player.stop()
            createPlayer()
        }
        Player.play()
    }
}
