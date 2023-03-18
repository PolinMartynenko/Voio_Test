//
//  MyPlaylistScreenViewModel.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 11.03.2023.
//

import Foundation
import UIKit

protocol MyPlaylistScreenViewModel {
    var firstSectionItems: [String] { get }
    
}

protocol MyPlaylistScreenViewModelDelegate: AnyObject {
    
}

class MyPlaylistScreenViewModelImplementation: MyPlaylistScreenViewModel {
    weak var delegate: MyPlaylistScreenViewModelDelegate?
    var model: MyPlaylistScreenModel
    var firstSectionItems: [String] = ["1","2","3"]
    
    init(model: MyPlaylistScreenModel) {
        self.model = model
    }
}

extension MyPlaylistScreenViewModelImplementation: MyPlaylistScreenModelDelegate {
    
}
