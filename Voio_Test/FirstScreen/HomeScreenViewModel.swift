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
    
    init(model: HomeScreenModel) {
        self.model = model
    }
    
    func viewDidLoad() {
        model.loadPlaylist()
    }
}

extension HomeScreenViewModelImplementation : HomeScreenModelDelegate {
    func didLoadPlaylist(_ items: [PlaylistlItem]) {
        self.firstSectionItems = items
        self.secondSectionItems = items
        self.thirdSectionItems = items
        delegate?.reloadData()
    }
}
