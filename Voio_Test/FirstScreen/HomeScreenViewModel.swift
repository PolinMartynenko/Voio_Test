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
    var secondSectionItems: [String] { get }
    var thirdSectionItems: [String] { get }
    
    func viewDidLoad()
}

protocol HomeScreenViewModelDelegate: AnyObject {
    func reloadData()
}

class HomeScreenViewModelImplementation: HomeScreenViewModel {
    var model : HomeScreenModel
    weak var delegate : HomeScreenViewModelDelegate?
    var firstSectionItems: [PlaylistlItem] = []
    var secondSectionItems: [String] = ["3", "2", "1", "3"]
    var thirdSectionItems: [String] = ["3", "2", "1", "3"]
    
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
        delegate?.reloadData()
    }
}
