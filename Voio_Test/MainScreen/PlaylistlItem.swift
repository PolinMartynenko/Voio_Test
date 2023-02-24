//
//  PlaylistlItem.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 16.10.2022.
//

import Foundation
import GoogleAPIClientForREST

struct PlaylistlItem {
    var playlist: GTLRYouTube_SearchResult
    var channelInfo: GTLRYouTube_Channel
}

struct VideoData {
    let data: GTLRYouTube_Video
}
