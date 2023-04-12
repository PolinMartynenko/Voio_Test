//
//  SettingsViewController.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 11.04.2023.
//

import Foundation
import UIKit
import GoogleSignIn

class SettingsViewController: UIViewController {
    var viewModel: SettingsViewModel
    let backArrowImage = UIImage(named: "left-arrow")
    let signOutButton = UIButton()
    
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
        setupSignOutButton()
        
    }
    
    private func setupBackArrowButton() {
        let arrowBackButton = UIBarButtonItem(image: backArrowImage, style:.plain, target: self, action: #selector(backToMyPlaylists))
        arrowBackButton.tintColor = .pinkColor
        navigationItem.leftBarButtonItem = arrowBackButton
    }
    
    @objc func backToMyPlaylists() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupSignOutButton() {
        signOutButton.setTitle("Sign Out", for: .normal)
        signOutButton.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 20)
        signOutButton.setTitleColor(.darkBackgroundColor, for: .normal)
        signOutButton.backgroundColor = .pinkColor
        signOutButton.layer.cornerRadius = 15
        signOutButton.addTarget(self, action: #selector(self.touchSignOut), for: .touchUpInside)
        view.addSubview(signOutButton)
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signOutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            signOutButton.heightAnchor.constraint(equalToConstant: 60),
            signOutButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    @objc func touchSignOut() {
         GIDSignIn.sharedInstance().signOut()
         
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension SettingsViewController: SettingsViewModelDelegate {
    
}
