//
//  PlayerScreenViewModel.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 30.10.2022.
//

import Foundation
import UIKit


protocol PlayerScreenViewModel {
    
}

protocol PlayerScreenViewModelDelegate: AnyObject {
    
}

class PlayerScreenViewModelImplementation: PlayerScreenViewModel {
    var model: PlayerScreenModel
    weak var delegate: PlayerScreenViewModelDelegate?
    
    init(model:PlayerScreenModel){
        self.model = model
    }
    
}

extension PlayerScreenViewModelImplementation: PlayerScreenModelDelegate {
    
}
