//
//  FirstScreenModel.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 08.10.2022.
//

import Foundation

protocol HomeScreenModel {
    
}

protocol HomeScreenModelDelegate: AnyObject {
    
}

class HomeScreenModelImplementation: NSObject, HomeScreenModel {
    weak var delegate : HomeScreenModelDelegate?
}
