//
//  FirstScreenModule.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 03.03.2023.
//

import Foundation

class FirstScreenModule {
        static func build() -> FirstScreenViewController {
            let model = FirstScreenModelImplementation()
            let viewModel = FirstScreenViewModelImplementation(model: model)
            let vc = FirstScreenViewController(viewModel: viewModel)
            viewModel.delegate = vc
            model.delegate = viewModel
            return vc
        }
    }

