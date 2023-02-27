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
    
}

class SearchScreenViewModelImplementation: SearchScreenViewModel {
    func onDidChangeText(_ text: String) {
        model.onDidChangeText(text)
    }
    
    
    var model: SearchScreenModel
    weak var delegate: SearchScreenViewModelDelegate?
    
    
    init(model: SearchScreenModel) {
        self.model = model
    }
}

extension SearchScreenViewModelImplementation: SearchScreenModelDelegate {
    
}
