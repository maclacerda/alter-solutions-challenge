//
//  DetailBot.swift
//  AlterSolutionsChallengeAppUITests
//
//  Created by Marcos Lacerda on 02/09/21.
//

import Foundation
import XCTest

final class DetailBot {

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
        return app.descendantElement(with: "detail.views.root")
    }()

    /// Buttons
    private lazy var addOrRemoveFavoriteButton: XCUIElement = {
        let button = app.buttons.containing(.button, identifier: "favorites").firstMatch

        return button
    }()
    
    // MARK: - Actions

    @discardableResult
    func takeScreenShot(_ activity: XCTActivity, _ name: String = "Screenshot", _ lifetime: XCTAttachment.Lifetime = .keepAlways) -> Self {
        testCase.takeScreenshot(activity: activity, name, lifetime)

        return self
    }

    @discardableResult
    func tapAddOrRemoveFavoriteButton() -> Self {
        addOrRemoveFavoriteButton.tap()
        return self
    }

    // MARK: - UI Validations
    
    @discardableResult
    public func checkFavoritesButtonExist() -> Self {
        let buttonExists = addOrRemoveFavoriteButton.exists

        XCTAssert(buttonExists, "AddOrRemoveFavorite button does not exist")

        return self
    }

    @discardableResult
    public func checkFaved() -> Self {
        let faved = addOrRemoveFavoriteButton.isSelected

        XCTAssertTrue(faved)

        return self
    }
    
    @discardableResult
    public func checkUnFaved() -> Self {
        let unfaved = addOrRemoveFavoriteButton.isSelected
        
        XCTAssertFalse(unfaved)
        
        return self
    }
    
    @discardableResult
    public func checkIfContainsLabelWithText(_ text: String) -> Self {
        let labelWithText = app.descendantElement(with: text)
        let labelWithTextExists = labelWithText.waitForExistence(timeout: 1.0)

        XCTAssertTrue(labelWithTextExists, "Label containing \(text) does not exists")

        return self
    }
    
    @discardableResult
    public func backScreen() -> Self {
        let backButton = app.navigationBars.buttons.element(boundBy: 0)

        XCTAssertTrue(backButton.exists)

        backButton.tap()

        return self
    }

}
