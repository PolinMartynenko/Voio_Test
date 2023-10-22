//
//  PlayerScreenModule.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 30.10.2022.
//

import Foundation
import UIKit

class PlayerScreenModule {
    static func build(_ item: PlayerItem, items: [PlayerItem]) -> UIViewController {
        let model = PlayerScreenModelImplementation()
        let viewModel = PlayerScreenViewModelImplementation(model: model, playerItem: item, items: items)
        let vc = PlayerScreenViewController(viewModel: viewModel)
        viewModel.delegate = vc
        model.delegate = viewModel
        return vc
    }
}
