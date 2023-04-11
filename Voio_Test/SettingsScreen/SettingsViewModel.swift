//
//  SettingsViewModel.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 11.04.2023.
//

import Foundation
import UIKit

protocol SettingsViewModel {
    
}

protocol SettingsViewModelDelegate: AnyObject {
    
}

class SettingsViewModelImplementation: SettingsViewModel {
    weak var delegate: SettingsViewModelDelegate?
    let model: SettingsModel
    
    init(model: SettingsModel) {
        self.model = model
    }
}

extension SettingsViewModelImplementation: SettingsModelDelegate {
    
}
