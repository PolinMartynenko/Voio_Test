//
//  MyPlaylistScreenViewController.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 11.03.2023.
//

import Foundation
import UIKit

class MyPlaylistScreenViewController: UIViewController {
    var viewModel: MyPlaylistScreenViewModel
    
    init(viewModel: MyPlaylistScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkBackgroundColor
    }
}

extension MyPlaylistScreenViewController: MyPlaylistScreenViewModelDelegate {
    
}
