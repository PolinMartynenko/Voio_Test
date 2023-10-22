//
//  FirstScreenViewModel.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 08.10.2022.
//

import Foundation
import GoogleAPIClientForREST

protocol HomeScreenViewModel {
    var firstSectionItems: [PlaylistlItem] { get }
    var secondSectionItems: [PlaylistlItem] { get }
    var thirdSectionItems: [PlaylistlItem] { get }
    var selectedItem: PlaylistlItem? { get set }
    var selectedSectionItems: [PlaylistlItem] { get set }
    
    func viewDidLoad()
}

protocol HomeScreenViewModelDelegate: AnyObject {
    func reloadData()
}

class HomeScreenViewModelImplementation: HomeScreenViewModel {
    
    var model : HomeScreenModel
    weak var delegate : HomeScreenViewModelDelegate?
    var firstSectionItems: [PlaylistlItem] = []
    var secondSectionItems: [PlaylistlItem] = []
    var thirdSectionItems: [PlaylistlItem] = []
    var selectedSectionItems: [PlaylistlItem] = []
    var selectedItem: PlaylistlItem?
    
    init(model: HomeScreenModel) {
        self.model = model
    }
    
    func viewDidLoad() {
        model.loadPlaylist()
        model.loadSecondPlaylist()
        model.loadThirdPlaylist()
    }
}

extension HomeScreenViewModelImplementation : HomeScreenModelDelegate {
    func didLoadPlaylist(_ items: [PlaylistlItem]) {
        self.firstSectionItems = items
        delegate?.reloadData()
    }
    
    func didLoadSecondPlaylist(_ items: [PlaylistlItem]) {
        self.secondSectionItems = items
        delegate?.reloadData()
    }
    
    func didLoadThirdPlaylist(_ items: [PlaylistlItem]) {
        self.thirdSectionItems = items
        delegate?.reloadData()
    }
}
