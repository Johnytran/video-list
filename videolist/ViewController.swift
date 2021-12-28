//
//  ViewController.swift
//  videolist
//
//  Created by Owner on 1/12/21.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    @IBOutlet weak var viewPlay: UIView!
    private var player: AVPlayer!
    let playerView = PlayerView()
    
    
    override func viewDidLoad() {
         super.viewDidLoad()
        playerView.backgroundColor = .red
        playerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.viewPlay.addSubview(playerView)
        
        playerView.heightAnchor.constraint(equalToConstant: 125).isActive = true

        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: viewPlay.topAnchor, constant: 0),
            playerView.bottomAnchor.constraint(equalTo: viewPlay.bottomAnchor, constant: 0),
            playerView.leadingAnchor.constraint(equalTo: viewPlay.leadingAnchor, constant: 0),
            playerView.trailingAnchor.constraint(equalTo: viewPlay.trailingAnchor, constant: 0)
        ])

        
        playVideo()

     }
//    git remote remove origin
//    git remote add origin https://[TOKEN]@github.com/[USER]/[REPO]
//    git push
     
    private func playVideo() {
            guard let path = Bundle.main.path(forResource: "remix", ofType:"mp4") else {
                debugPrint("video.m4v not found")
                return
            }
            
            playerView.prepareToPlay(withUrl: URL(fileURLWithPath: path))
        
        }

}


