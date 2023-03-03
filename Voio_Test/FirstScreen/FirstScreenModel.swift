//
//  FirstScreenModel.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 03.03.2023.
//

import Foundation

protocol FirstScreenModel {
}

protocol FirstScreenModelDelegate: AnyObject {
}

class FirstScreenModelImplementation: FirstScreenModel {
    
    weak var delegate: FirstScreenModelDelegate?
}

