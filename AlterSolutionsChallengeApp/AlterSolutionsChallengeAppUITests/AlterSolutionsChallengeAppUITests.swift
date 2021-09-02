//
//  AlterSolutionsChallengeAppUITests.swift
//  AlterSolutionsChallengeAppUITests
//
//  Created by Marcos Lacerda on 27/08/21.
//

import XCTest

class AlterSolutionsChallengeAppUITests: XCTestCase {

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }

}
