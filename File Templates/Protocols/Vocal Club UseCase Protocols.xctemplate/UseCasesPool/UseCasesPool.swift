//
//  UseCasesPool.swift
//  VocalClub
//
//  Created by NLT on 10/21/20.
//  Copyright © 2020 VocalClub. All rights reserved.
//

import Foundation

final class UseCasePool: UseCasePoolProtocol {
    
    var isExecutingAllowed: Bool = false
    var networkChainMemento: NetworkChainControllersMemento
    
    private var useCasesPool: [UseCaseExecutable] = []
    private let queue = DispatchQueue(label: "apic.poolQueue", attributes: .concurrent)
    private let semaphore = DispatchSemaphore.init(value: 1)
    
    init(networkChainMemento: NetworkChainControllersMemento) {
        self.networkChainMemento = networkChainMemento
    }
    
}

extension UseCasePool {
    
    func scheduleUseCase(useCase: UseCaseExecutable) {
        semaphore.wait()
        useCasesPool.append(useCase)
        semaphore.signal()
        queue.async {
            
            if self.isExecutingAllowed || !useCase.accessTokenRequired {
                useCase.execute(networkChainMemento: self.networkChainMemento) {
                    self.removeFromPool(useCase: useCase)
                }
            }
        }
    }
    
    func removeFromPool(useCase: UseCaseExecutable) {
        semaphore.wait()
        useCasesPool.removeAll { $0 === useCase }
        semaphore.signal()
    }
    
    func pauseUseCasePerforming() {
        isExecutingAllowed = false
        semaphore.wait()
        useCasesPool.forEach {
            if $0.accessTokenRequired {
                $0.cancelRequest()
            }
        }
        semaphore.signal()
    }
    
    func removePendingUseCases() {
        semaphore.wait()
        useCasesPool.removeAll()
        semaphore.signal()
    }
    
    func resumeUseCasePerforming() {
        if isExecutingAllowed {
            return
        }
        isExecutingAllowed = true
        semaphore.wait()
        for useCase in useCasesPool where useCase.accessTokenRequired {
            
            useCase.execute(networkChainMemento: self.networkChainMemento) {
                self.removeFromPool(useCase: useCase)
            }
            
        }
        semaphore.signal()
    }
    
}
