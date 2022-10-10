//
//  FirstScreenViewModel.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 08.10.2022.
//

import Foundation

protocol HomeScreenViewModel {
    var firstSectionItems: [String] { get }
}

protocol HomeScreenViewModelDelegate: AnyObject {
    
}

class HomeScreenViewModelImplementation: HomeScreenViewModel {
    var model : HomeScreenModel
    weak var delegate : HomeScreenViewModelDelegate?
    var firstSectionItems: [String] = ["1", "2", "3"]
    
    init(model: HomeScreenModel) {
        self.model = model
    }
}

extension HomeScreenViewModelImplementation : HomeScreenModelDelegate {
    
}
