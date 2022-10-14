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
    
    func loadChannels()
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
            
            self?.delegate?.reloadData()
        }
    }
}

extension HomeScreenViewModelImplementation : HomeScreenModelDelegate {
    
}
