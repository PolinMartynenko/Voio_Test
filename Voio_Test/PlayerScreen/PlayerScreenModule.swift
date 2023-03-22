//
//  PlayerScreenModule.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 30.10.2022.
//

import Foundation
import UIKit

class PlayerScreenModule {
    static func build(_ item: PlayerItem) -> UIViewController {
        let model = PlayerScreenModelImplementation()
        let viewModel = PlayerScreenViewModelImplementation(model: model, playerItem: item)
        let vc = PlayerScreenViewController(viewModel: viewModel)
        viewModel.delegate = vc
        model.delegate = viewModel
        return vc
    }
}
