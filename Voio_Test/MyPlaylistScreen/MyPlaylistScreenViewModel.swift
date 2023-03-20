//
//  MyPlaylistScreenViewModel.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 11.03.2023.
//

import Foundation
import UIKit

protocol MyPlaylistScreenViewModel {
    var firstSectionItems: [PlaylistlItem] { get }
    var secondSectionItems: [String] { get }
    var thirdSectionItems: [String] { get }
    
    func onViewDidLoad()
}

protocol MyPlaylistScreenViewModelDelegate: AnyObject {
    func reloadData()
}

class MyPlaylistScreenViewModelImplementation: MyPlaylistScreenViewModel {
    weak var delegate: MyPlaylistScreenViewModelDelegate?
    var model: MyPlaylistScreenModel
    var firstSectionItems: [PlaylistlItem] = []
    var secondSectionItems: [String] = ["2", "1", "1", "3", "2", "1", "1", "3"]
    var thirdSectionItems: [String] = ["2", "1", "1", "3", "2", "1"]
    
    init(model: MyPlaylistScreenModel) {
        self.model = model
    }
    
    func onViewDidLoad() {
        model.loadPlaylist()
    }
}

extension MyPlaylistScreenViewModelImplementation: MyPlaylistScreenModelDelegate {
    func didLoadPlaylist(_ items: [PlaylistlItem]) {
        self.firstSectionItems = items
        delegate?.reloadData()
    }
}
