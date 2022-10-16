//
//  HomeScreenCollectionViewCell.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 09.10.2022.
//

import Foundation
import UIKit
import GoogleAPIClientForREST
import SDWebImage

class GalleryCollectionViewCell: UICollectionViewCell {
    static let reuseId = "gallery_cell"
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let subsciberCountLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setupImageView()
        setupSubscrierCount()
        setupTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
    
    func setup(_ snippet: GTLRYouTube_SearchResultSnippet, subscribersCount: Int?) {
        if let path = snippet.thumbnails?.high?.url, let url = URL(string: path) {
            imageView.sd_setImage(with: url, completed: nil)
        }
        
        titleLabel.text = snippet.channelTitle
        
        if let subscribersCount = subscribersCount {
            subsciberCountLabel.text = "\(subscribersCount) подписчика"
        }
        
    }
    
    private func setupImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.makeRounded()
        self.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func setupTitle() {
        titleLabel.textColor = .white
        titleLabel.backgroundColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -10),
            titleLabel.bottomAnchor.constraint(equalTo: subsciberCountLabel.topAnchor)
        ])
    }
    
    func setupSubscrierCount() {
        subsciberCountLabel.textColor = .white
        subsciberCountLabel.backgroundColor = .black
        subsciberCountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subsciberCountLabel)
        
        NSLayoutConstraint.activate([
            subsciberCountLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 10),
            subsciberCountLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -10),
            subsciberCountLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -20)
        ])
    }
}
