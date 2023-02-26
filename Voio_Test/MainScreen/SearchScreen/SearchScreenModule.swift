//
//  SearchScreenModule.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 26.02.2023.
//

import Foundation
import UIKit

class SearchScreenModule {
    static func build() -> UIViewController {
        let model = SearchScreenModelImplementation()
        let viewModel = SearchScreenViewModelImplementation(model: model)
        let vc = SearchScreenViewController(viewModel: viewModel)
        viewModel.delegate = vc
        model.delegate = viewModel
        return vc
    }
}
