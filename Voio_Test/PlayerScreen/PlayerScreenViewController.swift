//
//  PlayerScreenViewController.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 30.10.2022.
//

import Foundation
import UIKit

class PlayerScreenViewController: UIViewController {
    
    let viewModel : PlayerScreenViewModel
    let playerButton = UIButton()
    let playerLabel = UILabel()

    init(viewModel: PlayerScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground()
        setupPlayerButton()
        setupPlayerLabel()
        
    }
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 223.0/255.0, green: 75.0/255.0, blue: 250.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 129.0/255.0, green: 0.0/255.0, blue: 250.0/255.0, alpha: 1.0).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    private func setupPlayerButton() {
        playerButton.backgroundColor = .pinkColor
        playerButton.layer.cornerRadius = 6
        view.addSubview(playerButton)
        playerButton.setImage(UIImage(named: "Close&Open"), for: .normal)
        playerButton.addTarget(self, action: #selector(self.playerButtonTouched), for: .touchUpInside)
        playerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerButton.topAnchor.constraint(equalTo: view.topAnchor),
            playerButton.heightAnchor.constraint(equalToConstant: 45),
            playerButton.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        playerButton.setNeedsLayout()
        playerButton.layoutIfNeeded()
    }
    
    @objc func playerButtonTouched(_ playerButton: UIButton){
        dismiss(animated: true, completion: nil)
        print("Touched")
    }
    
    private func setupPlayerLabel() {
        playerLabel.backgroundColor = .darkBackgroundColor
        view.addSubview(playerLabel)
        playerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerLabel.topAnchor.constraint(equalTo: playerButton.bottomAnchor),
            playerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -460)
        ])
    }
    
}



extension PlayerScreenViewController: PlayerScreenViewModelDelegate {
    
}


