//
//  HomeScreenCollectionViewCell.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 09.10.2022.
//

import Foundation
import UIKit

class HomeScreenCollectionViewCell: UICollectionViewCell {
    var imageView = UIImageView()
    

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.makeRounded()
        self.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

extension UIImageView {
    
    func makeRounded() {
        
        layer.borderWidth = 1
        layer.masksToBounds = false
        layer.cornerRadius = 10
        clipsToBounds = true
    }
}
