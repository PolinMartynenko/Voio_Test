//
//  MyPlaylistScreenModel.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 11.03.2023.
//

import Foundation
import UIKit

protocol MyPlaylistScreenModel {
    
}

protocol MyPlaylistScreenModelDelegate: AnyObject {
    
}

class MyPlaylistScreenModelImplementation: MyPlaylistScreenModel {
    weak var delegate: MyPlaylistScreenModelDelegate?
}
