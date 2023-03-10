//
//  FirstScreenViewController.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 23.02.2023.
//

import UIKit
import GoogleSignIn

class WelcomeScreenViewController: UIViewController {
    
    var viewModel: WelcomeScreenViewModel
    let logoImageView = UIImageView()
    let stackView = UIStackView()
    let registrationLabel = UILabel()
    let welcomeLabel = UILabel()
    let musicLabLabel = UILabel()
    let signInGoogleButton = GIDSignInButton()
    let registrationButton = UIButton()
    let skiptButton = UIButton()
    
    init(viewModel: WelcomeScreenViewModel) {
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
        setupwelcomeLabel()
        setupMusicLabLabel()
        setupStackViewForButtons()
        
        GIDSignIn.sharedInstance().uiDelegate = self
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
    
    private func setupwelcomeLabel() {
        welcomeLabel.text = "Welcome,"
        welcomeLabel.font = UIFont(name: "Poppins-Bold", size: 30)
        welcomeLabel.textColor = .white
        welcomeLabel.textAlignment = .center
        view.addSubview(welcomeLabel)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 40),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
    
    private func setupMusicLabLabel() {
        musicLabLabel.text = "MusicLab"
        musicLabLabel.font = UIFont(name: "FredokaOne-Regular", size: 60)
        musicLabLabel.textColor = .white
        musicLabLabel.textAlignment = .center
        view.addSubview(musicLabLabel)
        musicLabLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            musicLabLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 20),
            musicLabLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
    
    private func setupStackViewForButtons() {
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .center
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: musicLabLabel.bottomAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60)
        ])
        
        setuRegistrationButton()
        setupSkipButton()
        
    }
    
    private func setupSignInGoogleButton() {
        stackView.addArrangedSubview(signInGoogleButton)
        signInGoogleButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signInGoogleButton.heightAnchor.constraint(equalToConstant: 60),
            signInGoogleButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func setuRegistrationButton() {
        registrationButton.setTitle("Sign in", for: .normal)
        registrationButton.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 20)
        registrationButton.setTitleColor(.darkBackgroundColor, for: .normal)
        registrationButton.backgroundColor = .pinkColor
        registrationButton.layer.cornerRadius = 15
        registrationButton.addTarget(self, action: #selector(self.touchSignUp), for: .touchUpInside)
        stackView.addArrangedSubview(registrationButton)
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            registrationButton.heightAnchor.constraint(equalToConstant: 60),
            registrationButton.widthAnchor.constraint(equalToConstant: 150)
        ])

    }
    
    @objc func touchSignUp() {
        GIDSignIn.sharedInstance().signIn()
    }
    
    private func setupSkipButton() {
        skiptButton.setTitle("Skip", for: .normal)
        skiptButton.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 20)
        skiptButton.setTitleColor(.pinkColor, for: .normal)
        skiptButton.addTarget(self, action: #selector(self.touchSkip), for: .touchUpInside)
        stackView.addArrangedSubview(skiptButton)
        skiptButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func touchSkip() {
        let homeViewController = HomeScreenModule.build()
        let navigationController = UINavigationController(rootViewController: homeViewController)
        navigationController.modalPresentationStyle = .fullScreen
        
        present(navigationController, animated: true)
        print("Button clicked and transition to next screen")
    }
    
}

extension WelcomeScreenViewController: WelcomeScreenViewModelDelegate {
    
}

extension WelcomeScreenViewController: GIDSignInUIDelegate {
    
}
