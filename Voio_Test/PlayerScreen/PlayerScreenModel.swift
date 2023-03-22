//
//  PlayerScreenModel.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 30.10.2022.
//

import Foundation
import UIKit
import GoogleAPIClientForREST

protocol PlayerScreenModel {
    func loadVideoData(_ item: PlayerItem)
}

protocol PlayerScreenModelDelegate: AnyObject {
    func didLoadVideoData(_ videoData: VideoData)
}

class PlayerScreenModelImplementation: PlayerScreenModel {
    weak var delegate: PlayerScreenModelDelegate?
    
    private var youTubeServices: GTLRYouTubeService
    
    init() {
        self.youTubeServices = GTLRYouTubeService()
        self.youTubeServices.apiKey = "AIzaSyDJujfnsfXihGLQeHrKTIS4C1RlMMYdZi4"
    }
    
    func loadVideoData(_ item: PlayerItem) {
        let query = GTLRYouTubeQuery_VideosList.query(withPart: "contentDetails")
        query.identifier = item.videoId

        youTubeServices.executeQuery(query) { [weak self] ticket, response, error in
            guard let listResponse = response as? GTLRYouTube_VideoListResponse else {
                print("⭕️ List response has wrong type")
                return
            }
            
            guard let videoData = listResponse.items?.first else {
                print("⭕️ Video data is missing")
                return
            }
            
            self?.delegate?.didLoadVideoData(VideoData(data: videoData))
        }
    }
}
