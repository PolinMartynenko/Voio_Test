//
//  PlayerScreenViewModel.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 30.10.2022.
//

import Foundation
import UIKit


protocol PlayerScreenViewModel {
    var playerItem: PlayerItem { get }
    var videoData: VideoData? { get }
    func viewDidLoad()
    
    func playNextVideo()
    func playPreviousVideo()
}

protocol PlayerScreenViewModelDelegate: AnyObject {
    func displayVideoData(_ videoData: VideoData)
}

class PlayerScreenViewModelImplementation: PlayerScreenViewModel {
    var playerItem: PlayerItem
    var playerItems: [PlayerItem]
    var videoData: VideoData?
    var model: PlayerScreenModel
    weak var delegate: PlayerScreenViewModelDelegate?
    
    init(model:PlayerScreenModel, playerItem: PlayerItem, items: [PlayerItem]) {
        self.model = model
        self.playerItem = playerItem
        self.playerItems = items
    }
    
    func viewDidLoad() {
        model.loadVideoData(playerItem)
    }
    
    func playNextVideo() {
        guard let index = playerItems.firstIndex(where: { $0.videoId == playerItem.videoId }) else {
            return
        }
        
        let nextIndex = playerItems.index(after: index)
        let next = playerItems[nextIndex]
        model.loadVideoData(next)
        playerItem = next
    }
    
    func playPreviousVideo() {
        guard let index = playerItems.firstIndex(where: { $0.videoId == playerItem.videoId }) else {
            return
        }
        
        let prevIndex = playerItems.index(before: index)
        let prev = playerItems[prevIndex]
        model.loadVideoData(prev)
        playerItem = prev
    }
}

extension PlayerScreenViewModelImplementation: PlayerScreenModelDelegate {
    func didLoadVideoData(_ videoData: VideoData) {
        self.videoData = videoData
        self.delegate?.displayVideoData(videoData)
    }
}
