//
//  PlayView.swift
//  videolist
//
//  Created by Owner on 26/12/21.
//

import Foundation
import UIKit
import AVKit

class PlayerView: UIView {

     override class var layerClass: AnyClass {
         return AVPlayerLayer.self
     }

     init() {
         super.init(frame: .zero)
         initialSetup()
     }
     
     required init?(coder: NSCoder) {
         super.init(frame: .zero)
         initialSetup()
     }
     
     private func initialSetup() {
         if let layer = self.layer as? AVPlayerLayer {
             // Do any configuration you want to the layer
             // We'll set the video gravity
             layer.videoGravity = AVLayerVideoGravity.resizeAspect
         }
     }
     private var urlAsset: AVURLAsset?
         
     func prepareToPlay(withUrl url:URL) {
         // 1.
         let options = [AVURLAssetPreferPreciseDurationAndTimingKey : true]
         let urlAsset = AVURLAsset(url: url, options: options)
         self.urlAsset = urlAsset
         
         // 2.
         let keys = ["tracks"]
         urlAsset.loadValuesAsynchronously(forKeys: keys, completionHandler: { [weak self] in
             guard let strongSelf = self else { return }
             // Assets loaded
             strongSelf.startLoading(urlAsset)
         })
     }
    private var playerItem:AVPlayerItem?
         // 6.
         private var assetPlayer:AVPlayer? {
             didSet {
                 DispatchQueue.main.async {
                     if let layer = self.layer as? AVPlayerLayer {
                         layer.player = self.assetPlayer
                     }
                 }
             }
         }
     private func startLoading(_ asset: AVURLAsset) {
         // 3.
         var error:NSError?
         let status:AVKeyValueStatus = asset.statusOfValue(forKey: "tracks", error: &error)
         if status == AVKeyValueStatus.loaded {
             // 4.
             let item = AVPlayerItem(asset: asset)
             self.playerItem = item
             // 5.
             let player = AVPlayer(playerItem: item)
             self.assetPlayer = player
             player.play()
         }
     }
    func play() {
         guard self.assetPlayer?.isPlaying == false else { return }
         DispatchQueue.main.async {
             self.assetPlayer?.play()
         }
     }
     
     func pause() {
         guard self.assetPlayer?.isPlaying == true else { return }
         DispatchQueue.main.async {
             self.assetPlayer?.pause()
         }
     }
     
     func cleanUp() {
         pause()
         urlAsset?.cancelLoading()
         urlAsset = nil
         assetPlayer = nil
     }
     
     deinit {
         cleanUp()
     }
}
extension AVPlayer {
     
     var isPlaying:Bool {
         get {
             return (self.rate != 0 && self.error == nil)
         }
     }
     
 }
