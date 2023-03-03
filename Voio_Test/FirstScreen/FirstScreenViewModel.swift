//
//  FirstScreenViewModel.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 03.03.2023.
//

import Foundation

protocol FirstScreenViewModel {
    
}

protocol FirstScreenViewModelDelegate: AnyObject {
    
}

class FirstScreenViewModelImplementation: FirstScreenViewModel {
    
    weak var delegate: FirstScreenViewModelDelegate?
    var model: FirstScreenModel
    
    init(model: FirstScreenModel) {
        self.model = model
    }
}

extension FirstScreenViewModelImplementation: FirstScreenModelDelegate {
    
}
