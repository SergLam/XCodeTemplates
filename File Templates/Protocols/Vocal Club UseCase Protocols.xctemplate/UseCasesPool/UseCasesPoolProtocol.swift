//
//  UseCasesPoolProtocol.swift
//  VocalClub
//
//  Created by NLT on 10/21/20.
//  Copyright © 2020 VocalClub. All rights reserved.
//

import Foundation

protocol UseCasePoolProtocol {
    
    var networkChainMemento: NetworkChainControllersMemento { get set }
    var isExecutingAllowed: Bool { get }
    
    /// Schedules Use Case to execution
    /// - Parameter useCase: Use case to be scheduled
    func scheduleUseCase(useCase: UseCaseExecutable)
    
    /// Puses performing all use cases. Usecases that have been already executed should be interapted
    func pauseUseCasePerforming()
    
    func removePendingUseCases()
    
    /// Schedules all use cases again
    func resumeUseCasePerforming()
    
}
