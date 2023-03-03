//
//  FirstScreenViewController.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 23.02.2023.
//

import UIKit

class FirstScreenViewController: UIViewController {
    
    var viewModel: FirstScreenViewModel
    let logoImageView = UIImageView()
    let stackView = UIStackView()
    let registrationLabel = UILabel()
    let welcomeMusicLabLabel = UILabel()
    let registrationButton = UIButton()
    let skiptButton = UIButton()
    
    init(viewModel: FirstScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkBackgroundColor
        setupLogoImageView()
        setupStackView()
    }
    
    private func setupLogoImageView() {
        logoImageView.image = UIImage(named: "logo_registration")
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
            
    }
    
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .center
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60)
        ])
        
        setupwelcomeMusicLabLabel()
    }
    
    private func setupwelcomeMusicLabLabel() {
        welcomeMusicLabLabel.text = "Welcome to MusicLab"
        welcomeMusicLabLabel.font = UIFont(name: "Poppins-Bold", size: 32)
        welcomeMusicLabLabel.textColor = .white
        welcomeMusicLabLabel.textAlignment = .center
        stackView.addArrangedSubview(welcomeMusicLabLabel)
        welcomeMusicLabLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            welcomeMusicLabLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
    
    
    
    
}

extension FirstScreenViewController: FirstScreenViewModelDelegate {
    
}
