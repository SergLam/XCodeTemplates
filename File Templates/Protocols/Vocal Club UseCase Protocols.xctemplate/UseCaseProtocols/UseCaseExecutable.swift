//
//  UseCaseExecutable.swift
//  VocalClub
//
//  Created by NLT on 10/21/20.
//  Copyright © 2020 VocalClub. All rights reserved.
//

import Foundation
import Alamofire

protocol UseCaseExecutable: class {
    
    var accessTokenRequired: Bool { get }
    
    var onFinished: (() -> Void)? { get set }
    
    func execute(networkChainMemento: NetworkChainControllersMemento, onFinished: @escaping () -> Void)
    
    func cancelRequest()
    
}

extension UseCaseExecutable {
    
    var accessTokenRequired: Bool {
        return true
    }
    
}
