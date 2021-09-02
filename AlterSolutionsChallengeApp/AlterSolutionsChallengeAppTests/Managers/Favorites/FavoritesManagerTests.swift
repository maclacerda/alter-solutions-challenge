//
//  FavoritesManagerTests.swift
//  AlterSolutionsChallengeAppTests
//
//  Created by Marcos Lacerda on 02/09/21.
//

import XCTest
@testable import AlterSolutionsChallengeApp
@testable import AlterSolutionsChallengeCore

class FavoritesManagerTests: XCTestCase {
    
    override class func setUp() {
        super.setUp()
        AlterSolutionsChallengeAppDependencies.registerDependencies()
    }

    // MARK: - Tests

    func testFavoritesManager_checkEmptyFavorites_ShouldBeEmptyFavorites() {
        let sut = FavoritesManagerSpy()

        XCTAssertNotNil(sut.favoritesManager)
        XCTAssertTrue(sut.favoritesManager.favorites.isEmpty)
    }

    func testFavoritesManager_favedPokemon_ShouldBeSucess() {
        let sut = FavoritesManagerSpy()
        let pokemon = Pokemon(name: "Bulbasaur", photo: "")
        
        sut.favoritesManager.faved(pokemon)

        XCTAssertFalse(sut.favoritesManager.favorites.isEmpty)
        XCTAssertTrue(sut.favoritesManager.isFaved("Bulbasaur"))
        XCTAssertEqual(sut.favoritesManager.favorites.first?.name, pokemon.name)
    }

    func testFavoritesManager_favedSamePokemon_ShouldBeNeverChange() {
        let sut = FavoritesManagerSpy()
        let pokemon = Pokemon(name: "Bulbasaur", photo: "")

        sut.favoritesManager.faved(pokemon)
        sut.favoritesManager.faved(pokemon)

        XCTAssertFalse(sut.favoritesManager.favorites.isEmpty)
        XCTAssertEqual(1, sut.favoritesManager.favorites.count)
        XCTAssertTrue(sut.favoritesManager.isFaved("Bulbasaur"))
    }

    func testFavoritesManager_unFavedPokemon_ShouldBeSuccess() {
        let sut = FavoritesManagerSpy()
        let pokemon = Pokemon(name: "Bulbasaur", photo: "")

        sut.favoritesManager.unfaved(pokemon)

        XCTAssertTrue(sut.favoritesManager.favorites.isEmpty)
    }

}

private class FavoritesManagerSpy {
    
    @DependencyInject
    var favoritesManager: FavoritesManagerProtocol

}
