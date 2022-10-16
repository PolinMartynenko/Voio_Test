//
//  FirstScreenModel.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 08.10.2022.
//

import Foundation
import GoogleAPIClientForREST

protocol HomeScreenModel {
    func loadPlaylist()
}

protocol HomeScreenModelDelegate: AnyObject {
    func didLoadPlaylist(_ items: [PlaylistlItem])
}

class HomeScreenModelImplementation: HomeScreenModel {
    weak var delegate : HomeScreenModelDelegate?
    var playlistSearchResults: [GTLRYouTube_SearchResult] = []
    
    private var youTubeServices: GTLRYouTubeService
    private var channelsInfo: [GTLRYouTube_Channel] = []
    
    init() {
        self.youTubeServices = GTLRYouTubeService()
        self.youTubeServices.apiKey = "AIzaSyDJujfnsfXihGLQeHrKTIS4C1RlMMYdZi4"
    }
    
    func loadPlaylist() {
        let query = GTLRYouTubeQuery_SearchList.query(withPart: "snippet")
        query.maxResults = 4
        query.q = "music"

        youTubeServices.executeQuery(query) { [weak self] ticket, response, error in
            guard let listResponse = response as? GTLRYouTube_SearchListResponse else {
                print("⭕️ List response has wrong type")
                return
            }
            
            self?.playlistSearchResults = listResponse.items ?? []
            self?.loadChannelsData(listResponse.items ?? [])
        }
    }
    
    private func loadChannelsData(_ items: [GTLRYouTube_SearchResult]) {
        let channelsIds = items.compactMap { $0.snippet?.channelId }
        
        let query = GTLRYouTubeQuery_ChannelsList.query(withPart: "statistics,snippet")
        query.identifier = channelsIds.joined(separator: ",")
        
        youTubeServices.executeQuery(query) { [weak self] ticket, response, error in
            guard let listResponse = response as? GTLRYouTube_ChannelListResponse else {
                print("⭕️ List response has wrong type")
                return
            }
            
            guard let self = self else { return }
            self.channelsInfo = listResponse.items ?? []

            let items = self.playlistSearchResults.compactMap({ playlist -> PlaylistlItem? in
                guard let channel = self.getChannel(for: playlist.snippet?.channelId) else { return nil }
                return PlaylistlItem(playlist: playlist, channelInfo: channel)
            })
            
            self.delegate?.didLoadPlaylist(items)
        }
    }
    
    private func getChannel(for channelId: String?) -> GTLRYouTube_Channel? {
        return channelsInfo.first(where: { channel in
            channel.identifier == channelId
        })
    }
}
