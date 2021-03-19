//
//  PresenterProtocol.swift
//  VocalClub
//
//  Created by NLT on 10/16/20.
//  Copyright © 2020 VocalClub. All rights reserved.
//

import Foundation
import UIKit

protocol PresenterProtocol: AnyObject {
    associatedtype View: ViewProtocol
    associatedtype Factory: FlowFactoryProtocol
    associatedtype FlowResult: FlowResultProtocol

    var view: View? { get set }
    var useCaseFactory: Factory { get set }
    var viewState: ViewControllerState? { get set }
    var api: APIClientProtocol { get set }
    var storage: StorageMementoProtocol { get set }
    var errorHandler: ErrorsHandlingServiceProtocol { get set }
    var onFinish: ((FlowResult) -> Void) { get set }
    
    func viewChangedState(state: ViewControllerState)
    func onDidLoadHandle()
    func onWillAppearHandle()
    func onDidAppearHandle()
    func onWillDisappearHandle()
    func onDidDisappearHandle()
    
    func handleError(_ error: Error)
    
    func nextAction()
    func backAction()
    
}

extension PresenterProtocol {
    
    func viewChangedState(state: ViewControllerState) {
        self.viewState = state
        switch state {
        case .didLoad:
            onDidLoadHandle()
        case .willAppear:
            onWillAppearHandle()
        case .didAppear:
            onDidAppearHandle()
        case .willDisappear:
            onWillDisappearHandle()
        case .didDisappear:
            onDidDisappearHandle()
        default:
            break
        }
    }
    
    func onDidLoadHandle() { }
    func onWillAppearHandle() { }
    func onDidAppearHandle() { }
    func onWillDisappearHandle() { }
    func onDidDisappearHandle() { }
    
    func handleError(_ error: Error) {
        errorHandler.handleError(error)
    }
    
    func nextAction() { }
    
    func backAction() { }
    
}

enum ViewControllerState: String, CaseIterable {
    
    case none
    case didLoad
    case willAppear
    case didAppear
    case willDisappear
    case didDisappear
}
