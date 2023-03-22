//
//  MyPlaylistScreenViewModel.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 11.03.2023.
//

import Foundation
import UIKit

protocol MyPlaylistScreenViewModel {
    var firstSectionItems: [MyPlaylistlItem] { get }
    var secondSectionItems: [String] { get }
    var thirdSectionItems: [String] { get }
    var selectedItem: MyPlaylistlItem? { get set }
    
    func onViewDidLoad()
}

protocol MyPlaylistScreenViewModelDelegate: AnyObject {
    func reloadData()
}

class MyPlaylistScreenViewModelImplementation: MyPlaylistScreenViewModel {
    weak var delegate: MyPlaylistScreenViewModelDelegate?
    var model: MyPlaylistScreenModel
    var firstSectionItems: [MyPlaylistlItem] = []
    var secondSectionItems: [String] = ["2", "1", "1", "3", "2", "1", "1", "3"]
    var thirdSectionItems: [String] = ["2", "1", "1", "3", "2", "1"]
    var selectedItem: MyPlaylistlItem?
    
    init(model: MyPlaylistScreenModel) {
        self.model = model
    }
    
    func onViewDidLoad() {
        model.loadPlaylist()
    }
}

extension MyPlaylistScreenViewModelImplementation: MyPlaylistScreenModelDelegate {
    func didLoadPlaylist(_ items: [MyPlaylistlItem]) {
        self.firstSectionItems = items
        delegate?.reloadData()
    }
}
