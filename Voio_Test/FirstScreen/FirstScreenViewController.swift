//
//  FirstScreenViewController.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 23.02.2023.
//

import UIKit

class FirstScreenViewController: UIViewController {
    
    var viewModel: FirstScreenViewModel
    
    init(viewModel: FirstScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FirstScreenViewController: FirstScreenViewModelDelegate {
    
}
