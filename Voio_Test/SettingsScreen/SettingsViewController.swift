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
    let backArrowImage = UIImage(named: "left-arrow")
    
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
        
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
        
        setupBackArrowButton()
        
    }
    
    private func setupBackArrowButton() {
        let arrowBackButton = UIBarButtonItem(image: backArrowImage, style:.plain, target: self, action: #selector(backToMyPlaylists))
        arrowBackButton.tintColor = .pinkColor
        navigationItem.leftBarButtonItem = arrowBackButton
    }
    
    @objc func backToMyPlaylists() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension SettingsViewController: SettingsViewModelDelegate {
    
}
