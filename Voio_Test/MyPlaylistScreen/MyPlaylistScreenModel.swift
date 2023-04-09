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
    func didLoadPlaylist(_ items: [GTLRYouTube_Playlist:[GTLRYouTube_PlaylistItem]])
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
    
    private func loadYoutubePlayList(q: String?, items: Int, completion: @escaping ([GTLRYouTube_Playlist:[GTLRYouTube_PlaylistItem]]) -> Void) {
        // создаем запрос на загрузку плейлистов
        let query = GTLRYouTubeQuery_PlaylistsList.query(withPart: "snippet,id")
        //моих плейлистов
        query.mine = true
        
        let token = GIDSignIn.sharedInstance().currentUser.authentication.accessToken
        query.additionalHTTPHeaders = ["Authorization": "Bearer \(token!)"]
        
        //выполняем запрос
        youTubeServices.executeQuery(query) { [weak self] ticket, response, error in
            //этот комплишен сработает как выполнится запрос
            guard let listResponse = response as? GTLRYouTube_PlaylistListResponse else {
                print("⭕️ List response has wrong type")
                return
            }
            let playlistList = listResponse.items ?? []
            
            //загружаем видео из загруженных плейлистов
            self?.loadYouTubePlaylistItem(items: playlistList) { itmesResponse in
                let playListItems = itmesResponse
                
                var playlistWithItems = [GTLRYouTube_Playlist:[GTLRYouTube_PlaylistItem]]()
                for key in playlistList {
                    playlistWithItems[key] = playListItems.filter({ $0.snippet?.playlistId == key.identifier
                    })
                }
                completion(playlistWithItems)
            }
        }
    }
    
    func loadYouTubePlaylistItem(items: [GTLRYouTube_Playlist],
                                 completion: @escaping ([GTLRYouTube_PlaylistItem]) -> Void) {

        // передаем плейлисты
        let group = DispatchGroup()
        var playlistItems = [GTLRYouTube_PlaylistItem]()
        for playlist in items {
            group.enter()
            //создаем запрос на загрузку видео из плейлистов
            let query = GTLRYouTubeQuery_PlaylistItemsList.query(withPart: "snippet")
            query.playlistId = playlist.identifier
            let token = GIDSignIn.sharedInstance().currentUser.authentication.accessToken
            query.additionalHTTPHeaders = ["Authorization": "Bearer \(token!)"]
            
            youTubeServices.executeQuery(query) { ticket, response, error in
                guard let listResponse = response as? GTLRYouTube_PlaylistItemListResponse else {
                    print("⭕️ List response has wrong type")
                    return
                }
                playlistItems.append(contentsOf: listResponse.items ?? [])
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            completion(playlistItems)
        }
        
    }
    
}

//extension GTLRYouTube_Playlist: Hashable {
////    override func hash(into hasher: inout Hasher) {
////        hasher.combine(self.identifier)
////    }
//}
