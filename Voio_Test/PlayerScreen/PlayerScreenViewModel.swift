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
}

protocol PlayerScreenViewModelDelegate: AnyObject {
    func displayVideoData(_ videoData: VideoData)
}

class PlayerScreenViewModelImplementation: PlayerScreenViewModel {
    var playerItem: PlayerItem
    var videoData: VideoData?
    var model: PlayerScreenModel
    weak var delegate: PlayerScreenViewModelDelegate?
    
    init(model:PlayerScreenModel, playerItem: PlayerItem) {
        self.model = model
        self.playerItem = playerItem
    }
    
    func viewDidLoad() {
        model.loadVideoData(playerItem)
    }
}

extension PlayerScreenViewModelImplementation: PlayerScreenModelDelegate {
    func didLoadVideoData(_ videoData: VideoData) {
        self.videoData = videoData
        self.delegate?.displayVideoData(videoData)
    }
}
