//
//  PlayerScreenViewModel.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 30.10.2022.
//

import Foundation
import UIKit


protocol PlayerScreenViewModel {
    var playListItem: PlaylistlItem { get }
}

protocol PlayerScreenViewModelDelegate: AnyObject {
    
}

class PlayerScreenViewModelImplementation: PlayerScreenViewModel {
    var playListItem: PlaylistlItem
    var model: PlayerScreenModel
    weak var delegate: PlayerScreenViewModelDelegate?
    
    init(model:PlayerScreenModel, playListItem: PlaylistlItem) {
        self.model = model
        self.playListItem = playListItem
    }
}

extension PlayerScreenViewModelImplementation: PlayerScreenModelDelegate {
    
}
