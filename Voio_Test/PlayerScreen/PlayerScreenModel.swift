//
//  PlayerScreenModel.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 30.10.2022.
//

import Foundation
import UIKit

protocol PlayerScreenModel {
    
}

protocol PlayerScreenModelDelegate: AnyObject {
    
}

class PlayerScreenModelImplementation: PlayerScreenModel {
    weak var delegate: PlayerScreenModelDelegate?
    
}
