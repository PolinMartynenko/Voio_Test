//
//  FirstScreenViewModel.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 08.10.2022.
//

import Foundation
import GoogleAPIClientForREST

protocol HomeScreenViewModel {
    var firstSectionItems: [GTLRYouTube_SearchResult] { get }
    var secondSectionItems: [String] { get }
    var thirdSectionItems: [String] { get }
    var channelsInfo: [GTLRYouTube_Channel] { get }
    
    func loadChannels()
    func getSubscriberCount(for channelId: String?) -> Int?
}

protocol HomeScreenViewModelDelegate: AnyObject {
    func reloadData()
}

class HomeScreenViewModelImplementation: HomeScreenViewModel {
    var model : HomeScreenModel
    weak var delegate : HomeScreenViewModelDelegate?
    var youTubeServices: GTLRYouTubeService
    var firstSectionItems: [GTLRYouTube_SearchResult] = []
    var secondSectionItems: [String] = ["3", "2", "1", "3"]
    var thirdSectionItems: [String] = ["3", "2", "1", "3"]
    
    var channelsInfo: [GTLRYouTube_Channel] = []
    
    init(model: HomeScreenModel) {
        self.model = model
        
        self.youTubeServices = GTLRYouTubeService()
        self.youTubeServices.apiKey = "AIzaSyDJujfnsfXihGLQeHrKTIS4C1RlMMYdZi4"
    }
    
    func loadChannels() {
        let query = GTLRYouTubeQuery_SearchList.query(withPart: "snippet")
        query.maxResults = 4
        query.q = "music"

        youTubeServices.executeQuery(query) { [weak self] ticket, response, error in
            guard let listResponse = response as? GTLRYouTube_SearchListResponse else {
                print("⭕️ List response has wrong type")
                return
            }
            
            self?.firstSectionItems = listResponse.items ?? []
            self?.loadChannelsData(listResponse.items ?? [])
            
            self?.delegate?.reloadData()
        }
    }
    
    func loadChannelsData(_ items: [GTLRYouTube_SearchResult]) {
        let channelsIds = items.compactMap { $0.snippet?.channelId }
        
        let query = GTLRYouTubeQuery_ChannelsList.query(withPart: "statistics,snippet")
        query.identifier = channelsIds.joined(separator: ",")
        
        youTubeServices.executeQuery(query) { [weak self] ticket, response, error in
            guard let listResponse = response as? GTLRYouTube_ChannelListResponse else {
                print("⭕️ List response has wrong type")
                return
            }
            
            self?.channelsInfo = listResponse.items ?? []
            self?.delegate?.reloadData()
        }
    }
    
    func getSubscriberCount(for channelId: String?) -> Int? {
        let channel = channelsInfo.first(where: { channel in
            channel.identifier == channelId
        })
        
        if let count = channel?.statistics?.subscriberCount {
            return Int(truncating: count)
        } else {
            return nil
        }
    }
}

extension HomeScreenViewModelImplementation : HomeScreenModelDelegate {
    
}
