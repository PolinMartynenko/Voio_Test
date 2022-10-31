//
//  PlayerScreenViewController.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 30.10.2022.
//

import Foundation
import UIKit
import youtube_ios_player_helper

class PlayerScreenViewController: UIViewController {
    
    let viewModel : PlayerScreenViewModel
    let playerButton = UIButton()
    let playerView = YTPlayerView()
    let verticalStackView = UIStackView()
    let titleVideo = UILabel()
    let subscribersLabel = UILabel()
    

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
        setupVerticalStackView()
        
        guard let videoId = viewModel.playListItem.playlist.identifier?.videoId else {
            return
        }
        
        playerView.load(withVideoId: videoId)
        playerView.playVideo()
        
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
        playerView.backgroundColor = .darkBackgroundColor
        view.addSubview(playerView)
        playerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: playerButton.bottomAnchor),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -460)
        ])
    }
    
    private func setupVerticalStackView() {
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 15
        verticalStackView.alignment = .center
        view.addSubview(verticalStackView)
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: playerView.bottomAnchor, constant: 30),
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
        
        setupTitleVideoLabel()
        setupSubscribersLabel()
        
    }
    
    private func setupTitleVideoLabel() {
        titleVideo.text = "fkvjd"
        titleVideo.textColor = .white
        titleVideo.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.addArrangedSubview(titleVideo)
    }
    
    private func setupSubscribersLabel() {
        subscribersLabel.text = "fdg"
        subscribersLabel.textColor = .white
        subscribersLabel.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.addArrangedSubview(subscribersLabel)
    }
    
}



extension PlayerScreenViewController: PlayerScreenViewModelDelegate {
    
}


