//
//  SearchScreenViewModel.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 26.02.2023.
//

import Foundation


protocol SearchScreenViewModel {
    
}

protocol SearchScreenViewModelDelegate: AnyObject {
    
}

class SearchScreenViewModelImplementation: SearchScreenViewModel {
    
    var model: SearchScreenModel
    weak var delegate: SearchScreenViewModelDelegate?
    
    
    init(model: SearchScreenModel) {
        self.model = model
    }
}

extension SearchScreenViewModelImplementation: SearchScreenModelDelegate {
    
}
