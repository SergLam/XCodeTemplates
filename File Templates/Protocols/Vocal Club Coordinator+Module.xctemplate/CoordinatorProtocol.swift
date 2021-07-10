//
//  CoordinatorProtocol.swift
//  VocalClub
//
//  Created by NLT on 10/16/20.
//  Copyright © 2020 VocalClub. All rights reserved.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {
    
    var type: CoordinatorTypes { get set }
    
    var childCoordinators: [CoordinatorProtocol] { get set }
    var navigationController: VCNavigationController { get set }
    var errorHandlingService: ErrorsHandlingServiceProtocol { get set }
    var storage: StorageMementoProtocol { get set }
    var apiClient: APIClientProtocol { get set }
    
    var parrentCoordinator: CoordinatorProtocol? { get set }
    
    func start()
    func didFinish(_ child: CoordinatorProtocol?, model: ModelProtocol?)
    
}

extension CoordinatorProtocol {
    
    func didFinish(_ child: CoordinatorProtocol? = nil, model: ModelProtocol? = nil) {
        parrentCoordinator?.didFinish(self, model: model)
    }
    
}
