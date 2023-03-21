//
//  MyPlaylistScreenModel.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 11.03.2023.
//

import Foundation
import GoogleAPIClientForREST
import GoogleSignIn
import FirebaseCore
import FirebaseAuth
import Firebase
import FirebaseAnalytics

protocol MyPlaylistScreenModel {
    func loadPlaylist()
}

protocol MyPlaylistScreenModelDelegate: AnyObject {
    func didLoadPlaylist(_ items: [MyPlaylistlItem])
}

class MyPlaylistScreenModelImplementation: NSObject, MyPlaylistScreenModel {
   
    weak var delegate: MyPlaylistScreenModelDelegate?
    
    private var youTubeServices: GTLRYouTubeService
    
    override init() {
        self.youTubeServices = GTLRYouTubeService()
        super.init()
        self.youTubeServices.apiKey = "AIzaSyCBeol05UZRICbDM10PoRCF6l-BVl_a6DM"
//        self.youTubeServices.authorizer = self
    }
    
    
    func loadPlaylist() {
        loadYoutubePlayList(q: "music", items: 4) { [weak self] result in
            self?.delegate?.didLoadPlaylist(result)
        }
    }
    
    private func loadYoutubePlayList(q: String?, items: Int, completion: @escaping ([MyPlaylistlItem]) -> Void) {
        let query = GTLRYouTubeQuery_PlaylistsList.query(withPart: "snippet")
        query.mine = true
        
        let token = GIDSignIn.sharedInstance().currentUser.authentication.accessToken
        query.additionalHTTPHeaders = ["Authorization": "Bearer \(token!)"]
        
        youTubeServices.executeQuery(query) { [weak self] ticket, response, error in
            guard let listResponse = response as? GTLRYouTube_PlaylistListResponse else {
                print("⭕️ List response has wrong type")
                return
            }
            let items = listResponse.items ?? []
            let completionItems = items.map({ myPlaylist -> MyPlaylistlItem in
                MyPlaylistlItem(myPlaylist: myPlaylist)
            })
            completion(completionItems)
        }
    }
}
