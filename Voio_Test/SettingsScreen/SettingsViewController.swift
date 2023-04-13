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
    let stackViewForAllElements = UIStackView()
    
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
        setupStackViewForAllElements()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        userImageView.layer.cornerRadius = userImageView.frame.size.width/2

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
    
    private func setupStackViewForAllElements() {
        stackViewForAllElements.axis = .horizontal
        stackViewForAllElements.spacing = 15
        stackViewForAllElements.alignment = .center
        view.addSubview(stackViewForAllElements)
        stackViewForAllElements.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackViewForAllElements.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackViewForAllElements.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            stackViewForAllElements.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
        
        setupUserImageView()
        setupStackViewForNameAndSurname()
        
    }
    
    private func setupStackViewForNameAndSurname() {
        stackViewForNameAndSurname.axis = .vertical
        stackViewForNameAndSurname.spacing = 15
        stackViewForNameAndSurname.alignment = .leading
        stackViewForAllElements.addArrangedSubview(stackViewForNameAndSurname)
        stackViewForNameAndSurname.translatesAutoresizingMaskIntoConstraints = false
        
        setupNameLabel()
        setupSurnameLabel()
        
    }
    
    private func setupNameLabel() {
        let userName = GIDSignIn.sharedInstance().currentUser.profile.givenName
        nameLabel.text = userName
        nameLabel.font = UIFont(name: "Poppins-Regular", size: 25)
//        nameLabel.backgroundColor = .pinkColor
        nameLabel.textColor = .white
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        stackViewForNameAndSurname.addArrangedSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupSurnameLabel() {
        let userSurname = GIDSignIn.sharedInstance().currentUser.profile.familyName
        surnameLabel.text = userSurname
        surnameLabel.font = UIFont(name: "Poppins-Regular", size: 25)
//        surnameLabel.backgroundColor = .pinkColor
        surnameLabel.textColor = .white
        surnameLabel.translatesAutoresizingMaskIntoConstraints = false
        stackViewForNameAndSurname.addArrangedSubview(surnameLabel)
        NSLayoutConstraint.activate([
            surnameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupUserImageView() {
        let userImage = GIDSignIn.sharedInstance().currentUser.profile.imageURL(withDimension: 320)
        if let userString = userImage?.absoluteString {
            userImageView.sd_setImage(with: URL(string: userString), completed: nil)
        }
        userImageView.clipsToBounds = true
        stackViewForAllElements.addArrangedSubview(userImageView)
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userImageView.heightAnchor.constraint(equalToConstant: 170),
            userImageView.widthAnchor.constraint(equalToConstant: 170)
        ])
    }
    
}

extension SettingsViewController: SettingsViewModelDelegate {
    
}
