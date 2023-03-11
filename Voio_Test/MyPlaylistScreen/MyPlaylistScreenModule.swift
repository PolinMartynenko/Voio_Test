//
//  MyPlaylistScreenModule.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 05.03.2023.
//

import Foundation
import UIKit

class MyPlaylistScreenModule {
        static func build() -> MyPlaylistScreenViewController {
            let model = MyPlaylistScreenModelImplementation()
            let viewModel = MyPlaylistScreenViewModelImplementation(model: model)
            let vc = MyPlaylistScreenViewController(viewModel: viewModel)
            viewModel.delegate = vc
            model.delegate = viewModel
            return vc
        }
    }

