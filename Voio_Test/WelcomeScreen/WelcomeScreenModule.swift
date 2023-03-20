//
//  WelcomeScreenModule.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 03.03.2023.
//

import Foundation

class WelcomeScreenModule {
        static func build() -> WelcomeScreenViewController {
            let model = WelcomeScreenModelImplementation()
            let viewModel = WelcomeScreenViewModelImplementation(model: model)
            let vc = WelcomeScreenViewController(viewModel: viewModel)
            viewModel.delegate = vc
            model.delegate = viewModel
            return vc
        }
    }

