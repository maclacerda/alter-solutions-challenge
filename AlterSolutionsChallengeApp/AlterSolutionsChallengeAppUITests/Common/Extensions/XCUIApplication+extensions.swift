//
//  XCUIApplication+extensions.swift
//  AlterSolutionsChallengeAppUITests
//
//  Created by Marcos Lacerda on 02/09/21.
//

import Foundation
import XCTest

extension XCUIApplication {

    // MARK: Public Helpers

    func descendantElement(with identifier: String) -> XCUIElement {
        return descendants(matching: .any).matching(identifier: identifier).firstMatch
    }

}
