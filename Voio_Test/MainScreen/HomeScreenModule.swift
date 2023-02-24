//
//  FirstScreenModule.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 08.10.2022.
//

import Foundation
import UIKit

class HomeScreenModule {
    static func build() -> UIViewController {
        let model = HomeScreenModelImplementation()
        let viewModel = HomeScreenViewModelImplementation(model: model)
        let vc = HomeScreenViewController(viewModel: viewModel)
        viewModel.delegate = vc
        model.delegate = viewModel
        return vc
    }
}
