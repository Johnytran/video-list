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
        
        
        playerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        playerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -120).isActive = true
        playerView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        playerView.heightAnchor.constraint(equalToConstant: 125).isActive = true
        
        
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
                 
            
            //let player = AVPlayer(url: URL(fileURLWithPath: path))
            
//            let playerController = AVPlayerViewController()
//            playerController.player = player
//            present(playerController, animated: true) {
//                player.play()
//            }
        }

}


