//
//  Environment.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 27/08/21.
//

import Foundation
import AlterSolutionsChallengeCore

enum Environment {

    static var baseURL: URL {
        SecurityManager.shared.salt = Constants.salt

        let base = try? SecurityManager.shared.reveal(Constants.baseURL)
    
        precondition(base != nil)

        return URL(string: base!)!
    }

}
