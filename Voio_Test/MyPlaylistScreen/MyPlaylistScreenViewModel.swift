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
    var secondSectionItems: [String] { get }
    var thirdSectionItems: [String] { get }
    
}

protocol MyPlaylistScreenViewModelDelegate: AnyObject {
    
}

class MyPlaylistScreenViewModelImplementation: MyPlaylistScreenViewModel {
    weak var delegate: MyPlaylistScreenViewModelDelegate?
    var model: MyPlaylistScreenModel
    var firstSectionItems: [String] = ["1","2","3"]
    var secondSectionItems: [String] = ["2", "1", "1", "3", "2", "1", "1", "3"]
    var thirdSectionItems: [String] = ["2", "1", "1", "3", "2", "1"]
    
    init(model: MyPlaylistScreenModel) {
        self.model = model
    }
}

extension MyPlaylistScreenViewModelImplementation: MyPlaylistScreenModelDelegate {
    
}
