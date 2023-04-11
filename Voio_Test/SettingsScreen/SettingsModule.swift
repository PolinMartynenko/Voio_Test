//
//  SettingsModule.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 11.04.2023.
//

import Foundation
import UIKit

class SettingsModule {
        static func build() -> SettingsViewController {
            let model = SettingsModelImplementation()
            let viewModel = SettingsViewModelImplementation(model: model)
            let vc = SettingsViewController(viewModel: viewModel)
            viewModel.delegate = vc
            model.delegate = viewModel
            return vc
        }
    }
