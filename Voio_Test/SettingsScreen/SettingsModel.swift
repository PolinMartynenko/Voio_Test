//
//  SettingsModel.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 11.04.2023.
//

import Foundation
import UIKit

protocol SettingsModel {
    
}

protocol SettingsModelDelegate: AnyObject {
    
}

class SettingsModelImplementation: SettingsModel {
    
    weak var delegate: SettingsModelDelegate?
    
}
