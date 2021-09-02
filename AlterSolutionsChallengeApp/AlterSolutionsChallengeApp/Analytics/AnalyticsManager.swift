//
//  AnalyticsManager.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 31/08/21.
//

import Foundation
import AlterSolutionsChallengeCore
import Firebase

final class AnalyticsManager: AnalyticsProtocol {

    // MARK: - Public API

    func sendEvent(with event: String, parameters: [String: Any]) {
        Analytics.logEvent(event.adjustEventNameIfNeeded(), parameters: parameters)
    }

}
