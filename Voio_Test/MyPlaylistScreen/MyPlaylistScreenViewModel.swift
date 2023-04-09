//
//  MyPlaylistScreenViewModel.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 11.03.2023.
//

import Foundation
import UIKit
import GoogleAPIClientForREST
import GoogleSignIn
import FirebaseCore
import FirebaseAuth
import Firebase
import FirebaseAnalytics

protocol MyPlaylistScreenViewModel {
    var sectionItems: [GTLRYouTube_Playlist:[GTLRYouTube_PlaylistItem]] { get }
//    var secondSectionItems: [String] { get }
//    var thirdSectionItems: [String] { get }
    var selectedItem: GTLRYouTube_PlaylistItem? { get set }
    
    func onViewDidLoad()
}

protocol MyPlaylistScreenViewModelDelegate: AnyObject {
    func reloadData()
}

class MyPlaylistScreenViewModelImplementation: MyPlaylistScreenViewModel {
    weak var delegate: MyPlaylistScreenViewModelDelegate?
    var model: MyPlaylistScreenModel
    var sectionItems: [GTLRYouTube_Playlist:[GTLRYouTube_PlaylistItem]] = [:]
//    var secondSectionItems: [String] = ["2", "1", "1", "3", "2", "1", "1", "3"]
//    var thirdSectionItems: [String] = ["2", "1", "1", "3", "2", "1"]
    var selectedItem: GTLRYouTube_PlaylistItem? = nil
    
    init(model: MyPlaylistScreenModel) {
        self.model = model
    }
    
    func onViewDidLoad() {
        model.loadPlaylist()
    }
}

extension MyPlaylistScreenViewModelImplementation: MyPlaylistScreenModelDelegate {
    func didLoadPlaylist(_ items: [GTLRYouTube_Playlist:[GTLRYouTube_PlaylistItem]]) {
        self.sectionItems = items
        delegate?.reloadData()
    }
}
