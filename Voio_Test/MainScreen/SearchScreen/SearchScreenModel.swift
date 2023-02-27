//
//  SearchScreenModel.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 26.02.2023.
//

import Foundation

protocol SearchScreenModel {
    func onDidChangeText(_ text: String)
}

protocol SearchScreenModelDelegate: AnyObject {
    
}

class SearchScreenModelImplementation: SearchScreenModel {
    func onDidChangeText(_ text: String) {
    
    }
    
    weak var delegate: SearchScreenModelDelegate?
}
