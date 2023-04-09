//
//  File.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 16.03.2023.
//

import Foundation
import UIKit
import SDWebImage
import GoogleAPIClientForREST
import GoogleSignIn
import FirebaseCore
import FirebaseAuth
import Firebase
import FirebaseAnalytics

class MyPlaylistCollectionViewCell: UICollectionViewCell {
    static let reuseId = "gallery_cell"
    let imageView = UIImageView()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ playlistItem: GTLRYouTube_PlaylistItem) {
        if let path = playlistItem.snippet?.thumbnails?.medium?.url, let url = URL(string: path) {
            imageView.sd_setImage(with: url, completed: nil)
        }

//        titleLabel.text = playlistItem.playlist.snippet?.channelTitle
//
//        if let subscribersCount = playlistItem.channelInfo?.statistics?.subscriberCount {
//            subsciberCountLabel.text = "\(subscribersCount) подписчика"
//        }
    }
    
//    func setupCell(colour: UIColor, image: UIImage?) {
//        self.backgroundColor = colour
//        self.imageView.image = image
//    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupImageView()
    }
    
    private func setupImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.makeRounded()
        self.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}
