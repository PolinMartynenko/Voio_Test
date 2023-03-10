//
//  FirstScreenModel.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 03.03.2023.
//

import Foundation

protocol WelcomeScreenModel {
}

protocol WelcomeScreenModelDelegate: AnyObject {
}

class WelcomeScreenModelImplementation: WelcomeScreenModel {
    
    weak var delegate: WelcomeScreenModelDelegate?
}

