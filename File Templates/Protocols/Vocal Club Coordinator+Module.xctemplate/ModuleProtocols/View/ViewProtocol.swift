//
//  ViewProtocol.swift
//  VocalClub
//
//  Created by NLT on 10/16/20.
//  Copyright © 2020 VocalClub. All rights reserved.
//

import Foundation

protocol ViewProtocol: AnyObject {
    
    associatedtype Presenter: PresenterProtocol
    
    var presenter: Presenter? { get set }
    
}
