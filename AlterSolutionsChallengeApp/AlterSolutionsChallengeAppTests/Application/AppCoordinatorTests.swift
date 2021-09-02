//
//  AppCoordinatorTests.swift
//  AlterSolutionsChallengeAppTests
//
//  Created by Marcos Lacerda on 01/09/21.
//

import XCTest
@testable import AlterSolutionsChallengeApp

class AppCoordinatorTests: XCTestCase {
    
    // MARK: Tests

    func testDefaultsBuild() {
        // Given
        let window = UIWindow()
        window.rootViewController = UINavigationController()

        // When
        let appCoordinator = AppCoordinator(window: window)

        // Then
        XCTAssertNotNil(appCoordinator)
    }
    
    func testStartWithMainFlow() {
        // Given
        let window = UIWindow()
        window.rootViewController = UINavigationController()
        
        // When
        let appCoordinator = AppCoordinator(window: window)
        appCoordinator.start()

        XCTAssertNotNil(appCoordinator.pokemonListCoordinator.presenter)
    }

}
