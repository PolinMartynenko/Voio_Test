//
//  SettingsViewController.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 11.04.2023.
//

import Foundation
import UIKit
import GoogleSignIn
import SDWebImage

class SettingsViewController: UIViewController {
    var viewModel: SettingsViewModel
    let backArrowImage = UIImage(named: "left-arrow")
    let signOutButton = UIButton()
    let userImageView = UIImageView()
    let stackViewForNameAndSurname = UIStackView()
    let nameLabel = UILabel()
    let surnameLabel = UILabel()
    
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
        
//        setupUserUmageView()
        setupStackViewForNameAndSurname()
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
    
//    private func setupUserUmageView() {
////        userImageView.sd_setImage(with: URL())
//        view.addSubview(userImageView)
//        userUmageView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            userUmageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            userUmageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            userUmageView.heightAnchor.constraint(equalToConstant: 150),
//            userUmageView.widthAnchor.constraint(equalToConstant: 150)
//        ])
//    }
    
    private func setupStackViewForNameAndSurname() {
        stackViewForNameAndSurname.axis = .vertical
        stackViewForNameAndSurname.spacing = 15
        stackViewForNameAndSurname.alignment = .center
        view.addSubview(stackViewForNameAndSurname)
        stackViewForNameAndSurname.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackViewForNameAndSurname.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackViewForNameAndSurname.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackViewForNameAndSurname.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        setupNameLabel()
        setupSurnameLabel()
        
    }
    
    private func setupNameLabel() {
        nameLabel.text = "fdfvdfvfnvdnvkl"
        nameLabel.backgroundColor = .pinkColor
        nameLabel.textColor = .white
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        stackViewForNameAndSurname.addArrangedSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setupSurnameLabel() {
        surnameLabel.text = "fdfvdfvfnvdnvkl"
        surnameLabel.backgroundColor = .pinkColor
        surnameLabel.textColor = .white
        surnameLabel.translatesAutoresizingMaskIntoConstraints = false
        stackViewForNameAndSurname.addArrangedSubview(surnameLabel)
        NSLayoutConstraint.activate([
            surnameLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
}

extension SettingsViewController: SettingsViewModelDelegate {
    
}
