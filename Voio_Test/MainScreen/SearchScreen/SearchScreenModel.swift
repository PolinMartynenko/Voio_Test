//
//  SearchScreenModel.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 26.02.2023.
//

import Foundation
import GoogleAPIClientForREST

protocol SearchScreenModel {
    func onDidChangeText(_ text: String)
}

protocol SearchScreenModelDelegate: AnyObject {
    func didLoadPlaylist(items: [PlaylistlItem])
}

class SearchScreenModelImplementation: SearchScreenModel {
    
    weak var delegate: SearchScreenModelDelegate?
    
    private var youTubeServices: GTLRYouTubeService
    
    init() {
        self.youTubeServices = GTLRYouTubeService()
        self.youTubeServices.apiKey = "AIzaSyDJujfnsfXihGLQeHrKTIS4C1RlMMYdZi4"
    }
    
    
    func onDidChangeText(_ text: String) {
        loadYoutubePlayList(q: text, items: 10) { [weak self] result in
            self?.delegate?.didLoadPlaylist(items: result)
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
            
            let completionItems = items.map({ playlist -> PlaylistlItem in
                PlaylistlItem(playlist: playlist, channelInfo: nil)
            })
                      
//            self?.loadChannelsData(items) { channelsInfo in
//                let items = items.compactMap({ playlist -> PlaylistlItem? in
//                    guard let channel = channelsInfo.first(where: { channel in
//                        channel.identifier == playlist.snippet?.channelId
//                    }) else { return nil }
//                    return PlaylistlItem(playlist: playlist, channelInfo: channel)
//                })
            completion(completionItems)
            }
        }
    }
    
//    private func loadChannelsData(_ items: [GTLRYouTube_SearchResult],
//                                  completion: @escaping ([GTLRYouTube_Channel]) -> Void) {
//        let channelsIds = items.compactMap { $0.snippet?.title }
//        
//        let query = GTLRYouTubeQuery_ChannelsList.query(withPart: "statistics,snippet")
//        query.identifier = channelsIds.joined(separator: ",")
//        
//        youTubeServices.executeQuery(query) { ticket, response, error in
//            guard let listResponse = response as? GTLRYouTube_ChannelListResponse else {
//                print("⭕️ List response has wrong type")
//                return
//            }
//            
//            completion(listResponse.items ?? [])
//        }
//    }

    
    

