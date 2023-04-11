//
//  SettingsViewController.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 11.04.2023.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    var viewModel: SettingsViewModel
    
    init(viewModel: SettingsViewModel) {
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

extension SettingsViewController: SettingsViewModelDelegate {
    
}
