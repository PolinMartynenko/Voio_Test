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
    func loadSecondPlaylist()
    func loadThirdPlaylist()
}

protocol HomeScreenModelDelegate: AnyObject {
    func didLoadPlaylist(_ items: [PlaylistlItem])
    func didLoadSecondPlaylist(_ items: [PlaylistlItem])
    func didLoadThirdPlaylist(_ items: [PlaylistlItem])
}

class HomeScreenModelImplementation: HomeScreenModel {
    weak var delegate : HomeScreenModelDelegate?
    
    
    private var youTubeServices: GTLRYouTubeService
    
    init() {
        self.youTubeServices = GTLRYouTubeService()
        self.youTubeServices.apiKey = "AIzaSyDJujfnsfXihGLQeHrKTIS4C1RlMMYdZi4"
    }

    
    func loadPlaylist() {
        loadYoutubePlayList(q: "music", items: 4) { [weak self] result in
            self?.delegate?.didLoadPlaylist(result)
        }
    }
    
    func loadSecondPlaylist() {
        loadYoutubePlayList(q: "rap", items: 10) { [weak self] result in
            self?.delegate?.didLoadSecondPlaylist(result)
        }
    }
    
    func loadThirdPlaylist() {
        loadYoutubePlayList(q: "pop", items: 10) { [weak self] result in
            self?.delegate?.didLoadThirdPlaylist(result)
        }
    }
    
    private func loadYoutubePlayList(q: String?, items: Int, completion: @escaping ([PlaylistlItem]) -> Void) {
        let query = GTLRYouTubeQuery_SearchList.query(withPart: "snippet")
        query.maxResults = UInt(items)
        query.q = q

        youTubeServices.executeQuery(query) { [weak self] ticket, response, error in
            guard let listResponse = response as? GTLRYouTube_SearchListResponse else {
                print("⭕️ List response has wrong type")
                return
            }
            
            let items = listResponse.items ?? []
            self?.loadChannelsData(items) { channelsInfo in
                let items = items.compactMap({ playlist -> PlaylistlItem? in
                    guard let channel = channelsInfo.first(where: { channel in
                        channel.identifier == playlist.snippet?.channelId
                    }) else { return nil }
                    return PlaylistlItem(playlist: playlist, channelInfo: channel)
                })
                
                DispatchQueue.main.async {
                    completion(items)
                }
            }
        }
    }
    
    private func loadChannelsData(_ items: [GTLRYouTube_SearchResult],
                                  completion: @escaping ([GTLRYouTube_Channel]) -> Void) {
        let channelsIds = items.compactMap { $0.snippet?.channelId }
        
        let query = GTLRYouTubeQuery_ChannelsList.query(withPart: "statistics,snippet")
        query.identifier = channelsIds.joined(separator: ",")
        
        youTubeServices.executeQuery(query) { ticket, response, error in
            guard let listResponse = response as? GTLRYouTube_ChannelListResponse else {
                print("⭕️ List response has wrong type")
                return
            }
            
            DispatchQueue.main.async {
                completion(listResponse.items ?? [])
            }
        }
    }

}
