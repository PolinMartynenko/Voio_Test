//
//  MyPlaylistScreenViewModel.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 11.03.2023.
//

import Foundation
import UIKit

protocol MyPlaylistScreenViewModel {
    
}

protocol MyPlaylistScreenViewModelDelegate: AnyObject {
    
}

class MyPlaylistScreenViewModelImplementation: MyPlaylistScreenViewModel {
    weak var delegate: MyPlaylistScreenViewModelDelegate?
    var model: MyPlaylistScreenModel
    
    init(model: MyPlaylistScreenModel) {
        self.model = model
    }
}

extension MyPlaylistScreenViewModelImplementation: MyPlaylistScreenModelDelegate {
    
}
