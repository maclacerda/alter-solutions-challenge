//
//  AlterSolutionsChallengeAppTests.swift
//  AlterSolutionsChallengeAppTests
//
//  Created by Marcos Lacerda on 27/08/21.
//

import XCTest
@testable import AlterSolutionsChallengeApp
import AlterSolutionsChallengeCore

// swiftlint:disable line_length
class AlterSolutionsChallengeAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        var sut = SecurityManager.shared
        sut.salt = [65, 108, 116, 101, 114, 83, 111, 108, 117, 116, 105, 111, 110, 115, 67, 104, 97, 108, 108, 101, 110, 103, 101, 77, 97, 114, 99, 111, 115]
        
        let result = try sut.obfuscate("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/%@.png")
        XCTAssertFalse(result.isEmpty)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
// swiftlint:enable line_length
