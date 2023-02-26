//
//  SearchScreenModel.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 26.02.2023.
//

import Foundation

protocol SearchScreenModel {
    
}

protocol SearchScreenModelDelegate: AnyObject {
    
}

class SearchScreenModelImplementation: SearchScreenModel {
    weak var delegate: SearchScreenModelDelegate?
}
