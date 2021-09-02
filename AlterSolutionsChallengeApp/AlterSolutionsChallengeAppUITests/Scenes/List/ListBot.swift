//
//  ListBot.swift
//  AlterSolutionsChallengeAppUITests
//
//  Created by Marcos Lacerda on 02/09/21.
//

import XCTest

final class ListBot {

    // MARK: Properties

    private let app: XCUIApplication
    private let testCase: XCTestCase

    // MARK: - Lifecycle

    required init(on app: XCUIApplication, for testCase: XCTestCase, wait timeout: TimeInterval = 1) {
        self.app = app
        self.testCase = testCase

        let rootViewExists = rootView.waitForExistence(timeout: timeout)
        XCTAssertTrue(rootViewExists, "\(String(describing: self)) not loaded in time")
    }

    // MARK: UIElements

    /// Views
    private lazy var rootView: XCUIElement = {
        return app.descendantElement(with: "list.views.root")
    }()

    /// Other elements

    private lazy var collectionView: XCUIElement = {
        let collectionView = app.collectionViews.firstMatch

        XCTAssertTrue(collectionView.exists, "CollectionView dos not exist")

        return collectionView
    }()
    
    // MARK: - Actions

    @discardableResult
    public func takeScreenShot(_ activity: XCTActivity, _ name: String = "Screenshot", _ lifetime: XCTAttachment.Lifetime = .keepAlways) -> Self {
        testCase.takeScreenshot(activity: activity, name, lifetime)

        return self
    }
    
    @discardableResult
    public func tapCell(with text: String) -> Self {
        let cellWithText = collectionView.cells.containing(.staticText, identifier: text).firstMatch

        XCTAssert(cellWithText.exists, "Cell containing \(text) does not exist")
        cellWithText.tap()

        return self
    }

    @discardableResult
    public func tapFavoritesButton() -> Self {
        let favoritesButton = app.buttons.containing(.button, identifier: "favorites").firstMatch

        XCTAssert(favoritesButton.exists, "Favorites button does not exist")
        favoritesButton.tap()

        return self
    }

}
