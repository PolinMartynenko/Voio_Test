//
//  FirstScreenViewModel.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 03.03.2023.
//

import Foundation

protocol WelcomeScreenViewModel {
    
}

protocol WelcomeScreenViewModelDelegate: AnyObject {
    
}

class WelcomeScreenViewModelImplementation: WelcomeScreenViewModel {
    
    weak var delegate: WelcomeScreenViewModelDelegate?
    var model: WelcomeScreenModel
    
    init(model: WelcomeScreenModel) {
        self.model = model
    }
}

extension WelcomeScreenViewModelImplementation: WelcomeScreenModelDelegate {
    
}
