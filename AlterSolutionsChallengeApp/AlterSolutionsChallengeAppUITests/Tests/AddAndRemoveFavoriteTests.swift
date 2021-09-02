//
//  AddAndRemoveFavoriteTests.swift
//  AlterSolutionsChallengeAppUITests
//
//  Created by Marcos Lacerda on 02/09/21.
//

import XCTest

class AddAndRemoveFavoriteTests: XCTestCase {
    
    // MARK: - Properties

    var app: XCUIApplication!
    var listBot: ListBot!
    var detailBot: DetailBot?
    var favoritesBot: FavoritesBot?

    // MARK: - Setup
    override func setUp() {
        super.setUp()
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()

        listBot = ListBot(on: app, for: self, wait: 4.0)
    }
    
    override func tearDown() {
        super.tearDown()
        detailBot = nil
    }

    // MARK: - Private Helpers

    private func mockPokemonList() {
        let pokemons = MockDataHelper.getData(forResource: .pokemonList)
        URLSession.mockNext(expression: "/pokemon/", body: pokemons)
    }

    private func mockBulbassaur() {
        let bulbassaur = MockDataHelper.getData(forResource: .bulbassaur)
        URLSession.mockNext(expression: "/pokemon/1", body: bulbassaur)
    }

    // MARK: - Tests

    func testAddToFavoritesWithBots() {
        mockPokemonList()
        mockBulbassaur()

        group("Given the List Scene is loaded") { activity in
            listBot.takeScreenShot(activity, "List Scene loaded")
                .tapCell(with: "Bulbasaur")
        }

        group("Selected Bulbasaur") { activity in
            detailBot = DetailBot(on: app, for: self, wait: 4.0)

            detailBot?.takeScreenShot(activity, "Detail Scene")
                .checkFavoritesButtonExist()
                .tapAddOrRemoveFavoriteButton()
                .checkFaved()
                .backScreen()
        }

        group("Check if Favorites contain Bulbasaur") { activity in
            listBot.tapFavoritesButton()

            favoritesBot = FavoritesBot(on: app, for: self, wait: 1.0)

            favoritesBot?.takeScreenShot(activity, "Favorites loaded")
                .checkIfContainsCell(with: "Bulbasaur")
                .tapCell(with: "Bulbasaur")

            detailBot?.takeScreenShot(activity, "Detail Scene")
                .tapAddOrRemoveFavoriteButton()
                .checkUnFaved()
                .backScreen()
        }
    }

}
