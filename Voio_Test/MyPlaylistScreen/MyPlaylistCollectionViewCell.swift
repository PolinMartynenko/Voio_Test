//
//  File.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 16.03.2023.
//

import Foundation
import UIKit

class MyPlaylistCollectionViewCell: UICollectionViewCell {
    static let reuseId = "gallery_cell"
    
    override init(frame: CGRect) {
        super .init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(colour: UIColor) {
        self.backgroundColor = colour
       }
    
}
