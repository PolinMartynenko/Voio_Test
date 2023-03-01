//
//  ThirdCollectionViewCell.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 30.10.2022.
//

import Foundation
import UIKit
import GoogleAPIClientForREST
import SDWebImage

class ThirdCollectionViewCell: UICollectionViewCell {
    static let reuseId = "third_cell"
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let subsciberCountLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setupImageView()
        setupTitle()
        setupSubscrierCount()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ playlistItem: PlaylistlItem) {
        if let path = playlistItem.playlist.snippet?.thumbnails?.high?.url, let url = URL(string: path) {
            imageView.sd_setImage(with: url, completed: nil)
        }

        titleLabel.text = playlistItem.playlist.snippet?.channelTitle

        if let subscribersCount = playlistItem.channelInfo?.statistics?.subscriberCount {
            subsciberCountLabel.text = "\(subscribersCount) подписчика"
        }
    }
    
    private func setupImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.makeRounded()
        self.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func setupTitle() {
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -10),
//            titleLabel.bottomAnchor.constraint(equalTo: subsciberCountLabel.topAnchor)
        ])
    }
    
    func setupSubscrierCount() {
        subsciberCountLabel.textColor = .white
        subsciberCountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subsciberCountLabel)
        NSLayoutConstraint.activate([
            subsciberCountLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            subsciberCountLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 10),
            subsciberCountLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -10),
            subsciberCountLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }
    
}
