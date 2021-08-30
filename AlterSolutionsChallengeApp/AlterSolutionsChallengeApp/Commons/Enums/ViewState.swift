//
//  ViewState.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 28/08/21.
//

import Foundation

enum ViewState {
    
    case loading
    case empty(String)
    case error(Error?)
    case loaded
    
}

extension ViewState: Equatable {
    
    static func == (lhs: ViewState, rhs: ViewState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading): return true
        case (.empty, .empty): return true
        case let (.error(lhs), .error(rhs)): return lhs.debugDescription == rhs.debugDescription
        case (.loaded, .loaded): return true
        default: return false
        }
    }
    
}
