//
//  FirstScreenViewModel.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 08.10.2022.
//

import Foundation
import GoogleAPIClientForREST

protocol HomeScreenViewModel {
    var firstSectionItems: [String] { get }
    var secondSectionItems: [String] { get }
    var thirdSectionItems: [String] { get }
    
    func loadChannels()
}

protocol HomeScreenViewModelDelegate: AnyObject {
    
}

class HomeScreenViewModelImplementation: HomeScreenViewModel {
    var model : HomeScreenModel
    weak var delegate : HomeScreenViewModelDelegate?
    var youTubeServices: GTLRYouTubeService
    var firstSectionItems: [String] = ["1", "2", "3"]
    var secondSectionItems: [String] = ["3", "2", "1", "3"]
    var thirdSectionItems: [String] = ["3", "2", "1", "3"]
    
    init(model: HomeScreenModel) {
        self.model = model
        
        self.youTubeServices = GTLRYouTubeService()
        self.youTubeServices.apiKey = "AIzaSyDJujfnsfXihGLQeHrKTIS4C1RlMMYdZi4"
    }
    
    func loadChannels() {
        let query = GTLRYouTubeQuery_SearchList.query(withPart: "music")
        query.maxResults = 4


        youTubeServices.executeQuery(query) { ticket, response, error in

        }
    }
}

extension HomeScreenViewModelImplementation : HomeScreenModelDelegate {
    
}
