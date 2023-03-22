//
//  PlayerScreenViewController.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 30.10.2022.
//

import Foundation
import UIKit
import youtube_ios_player_helper
import MediaPlayer

class PlayerScreenViewController: UIViewController {
    
    let viewModel : PlayerScreenViewModel
    let playerButton = UIButton()
    let playerView = YTPlayerView()
    let verticalStackView = UIStackView()
    let titleVideo = UILabel()
    let subscribersLabel = UILabel()
    let sliderForVideo = UISlider()
    let timeStackView = UIStackView()
    let startTimeLabel = UILabel()
    let finishTimeLebel = UILabel()
    let horizontalStackView = UIStackView()
    let pastVieoButton = UIButton()
    let pauseVideoButton = UIButton()
    let nextVideoButton = UIButton()
    var isVideoPlaying = Bool()
    var sliderForSound = UISlider()
    

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
        setupHorizontalStackView()
        setupSliderForSound()
        
       let videoId = viewModel.playerItem.videoId
        
        playerView.load(withVideoId: videoId)
        
        viewModel.viewDidLoad()
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
            verticalStackView.topAnchor.constraint(equalTo: playerView.bottomAnchor, constant: 50),
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
        
        setupSliderForVideo()
        setupTimeStackView()
        setupTitleVideoLabel()
//        setupSubscribersLabel()
        
    }
    
    private func setupSliderForVideo() {
        sliderForVideo.frame = CGRect(x: 0, y: 0, width: 100, height: 23)
        sliderForVideo.minimumValue = 0
        sliderForVideo.maximumValue = 100
        sliderForVideo.isContinuous = true
        sliderForVideo.setThumbImage(UIImage(named: "vertical-line"), for: .normal)
        sliderForVideo.tintColor = .white
        sliderForVideo.addTarget(self, action: #selector(changeSliderForVideo), for: .valueChanged)
        verticalStackView.addArrangedSubview(sliderForVideo)
        sliderForVideo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sliderForVideo.heightAnchor.constraint(equalToConstant: 10),
            sliderForVideo.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor)
        ])
        
        verticalStackView.setCustomSpacing(20, after: sliderForVideo)
        
    }
    
    @objc func changeSliderForVideo(sender: UISlider){
        print("change")
    }
    
    
    private func setupTimeStackView() {
        timeStackView.axis = .horizontal
        timeStackView.spacing = 15
        timeStackView.alignment = .center
        timeStackView.distribution = .equalCentering
        verticalStackView.addArrangedSubview(timeStackView)
        timeStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeStackView.heightAnchor.constraint(equalToConstant: 15),
            timeStackView.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor)
        ])
        
        setupStartTimeLabel()
        setupFinishTimeLabel()
        
    }
    
    private func setupStartTimeLabel() {
        startTimeLabel.text = "0:0"
        startTimeLabel.textColor = .white
        startTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeStackView.addArrangedSubview(startTimeLabel)
    }
    
    private func setupFinishTimeLabel() {
        finishTimeLebel.textColor = .white
        finishTimeLebel.translatesAutoresizingMaskIntoConstraints = false
        timeStackView.addArrangedSubview(finishTimeLebel)
    }
    
    private func setupTitleVideoLabel() {
//        titleVideo.text = viewModel.playListItem.playlist.snippet?.channelTitle
        titleVideo.font = .boldSystemFont(ofSize: 30)
        titleVideo.textColor = .white
        titleVideo.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.addArrangedSubview(titleVideo)
    }
    
//    private func setupSubscribersLabel() {
//        if let subscribersCount =  viewModel.playListItem.channelInfo?.statistics?.subscriberCount {
//            subscribersLabel.text = "\(subscribersCount) подписчика" }
//        subscribersLabel.textColor = .white
//        subscribersLabel.translatesAutoresizingMaskIntoConstraints = false
//        verticalStackView.addArrangedSubview(subscribersLabel)
//    }
//
    private func setupHorizontalStackView() {
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 40
        horizontalStackView.alignment = .center
        horizontalStackView.distribution = .equalCentering
        view.addSubview(horizontalStackView)
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: verticalStackView.bottomAnchor, constant: 40),
            horizontalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        setupPastVideoButton()
        setupPauseVideoButton()
        setupNextVideoButton()
        
    }
    
    private func setupPastVideoButton() {
        horizontalStackView.addArrangedSubview(pastVieoButton)
        pastVieoButton.setImage(UIImage(named: "Prev"), for: .normal)
//        pastVieoButton.addTarget(self, action: #selector(self.playerButtonTouched), for: .touchUpInside)
        pastVieoButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupPauseVideoButton() {
        horizontalStackView.addArrangedSubview(pauseVideoButton)
        pauseVideoButton.setImage(UIImage(named: "Play"), for: .normal)
        pauseVideoButton.addTarget(self, action: #selector(self.playPauseButtonTouched), for: .touchUpInside)
        pauseVideoButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func playPauseButtonTouched(_ playerPauseButton: UIButton){
        if isVideoPlaying {
            playerView.pauseVideo()
            isVideoPlaying = false
            pauseVideoButton.setImage(UIImage(named: "Play"), for: .normal)
        } else {
            playerView.playVideo()
            isVideoPlaying = true
            pauseVideoButton.setImage(UIImage(named: "Pause"), for: .normal)
        }
        print("Touched")
    }
    
    private func setupNextVideoButton() {
        horizontalStackView.addArrangedSubview(nextVideoButton)
        nextVideoButton.setImage(UIImage(named: "Next"), for: .normal)
//        pastVieoButton.addTarget(self, action: #selector(self.playerButtonTouched), for: .touchUpInside)
        nextVideoButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupSliderForSound() {
        sliderForSound.frame = CGRect(x: 0, y: 0, width: 80, height: 23)
        sliderForSound.minimumValueImage = UIImage(named: "Sound_Min")
        sliderForSound.maximumValueImage = UIImage(named: "Sound_Max")
        sliderForSound.isContinuous = true
        sliderForSound.tintColor = .white
        sliderForSound.addTarget(self, action: #selector(changeSlider), for: .valueChanged)
        view.addSubview(sliderForSound)
        sliderForSound.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sliderForSound.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: 25),
            sliderForSound.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            sliderForSound.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            sliderForSound.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60)
        ])
        
    }

    @objc func changeSlider(sender: UISlider){
        MPVolumeView.setVolume(sender.value)
    }
    
}

extension PlayerScreenViewController: PlayerScreenViewModelDelegate {
    func displayVideoData(_ videoData: VideoData) {
        guard let duration = videoData.data.contentDetails?.duration else {
            return
        }
        
        let components = duration.components(separatedBy: .letters)
        
        finishTimeLebel.text = components.joined(separator: ":")
    }
}

