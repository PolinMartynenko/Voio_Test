//
//  HeaderCollectionReusableView.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 29.10.2022.
//

import Foundation
import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "HeaderCollectionReusableView"
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Playlist Name"
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    public func configure() {
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    
}
