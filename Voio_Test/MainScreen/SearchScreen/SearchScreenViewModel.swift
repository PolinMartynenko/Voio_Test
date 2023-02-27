//
//  SearchScreenViewModel.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 26.02.2023.
//

import Foundation


protocol SearchScreenViewModel {
    func onDidChangeText(_ text: String)
}

protocol SearchScreenViewModelDelegate: AnyObject {
    func reloadData()
}

class SearchScreenViewModelImplementation: SearchScreenViewModel {
   
    var model: SearchScreenModel
    weak var delegate: SearchScreenViewModelDelegate?
    var playlistItems: [PlaylistlItem] = []
    
    
    init(model: SearchScreenModel) {
        self.model = model
    }
    
    func onDidChangeText(_ text: String) {
        model.onDidChangeText(text)
    }
    
}

extension SearchScreenViewModelImplementation: SearchScreenModelDelegate {
    func didLoadPlaylist(items: [PlaylistlItem]) {
        self.playlistItems = items
        delegate?.reloadData()
    }
    
    
}
