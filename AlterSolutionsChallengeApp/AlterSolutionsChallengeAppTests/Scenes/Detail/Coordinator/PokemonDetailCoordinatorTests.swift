//
//  PokemonDetailCoordinatorTests.swift
//  AlterSolutionsChallengeAppTests
//
//  Created by Marcos Lacerda on 01/09/21.
//

import XCTest
@testable import AlterSolutionsChallengeApp

class PokemonDetailCoordinatorTests: XCTestCase {

    // MARK: - Properties
    
    var presenter: BaseNavigationViewController!
    var sut: PokemonDetailCoordinatorSpy!
    var pokemon: PokemonDetail!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()

        presenter = BaseNavigationViewController()
        pokemon = PokemonDetail(pokemon: Pokemon(name: "Pokemon", photo: "Photo", isFaved: false))
        sut = PokemonDetailCoordinatorSpy()
    }
    
    // MARK: - Tests
    
    func testListCoordinator_start_ShouldBeCalled() {
        // Given
        sut.presenter = presenter
        sut.pokemon = pokemon

        // When
        sut.start()
        
        // Then
        XCTAssertNotNil(sut.presenter)
        XCTAssertNotNil(sut.pokemon)
        XCTAssertTrue(sut.startCalled)
    }
    
    func testListCoordinator_didNotifyFavedUnFavedPokemon_ShouldBeCalled() {
        // When
        sut.didNotifyFavedUnFavedPokemon()
        
        // Then
        XCTAssertTrue(sut.didNotifyFavedUnFavedPokemonCalled)
    }

}

class PokemonDetailCoordinatorSpy: PokemonDetailCoordinatorProtocol, PokemonDetailViewControllerDelegate {

    var presenter: BaseNavigationViewController?
    var pokemon: PokemonDetail?
    var startCalled: Bool = false
    var didNotifyFavedUnFavedPokemonCalled: Bool = false

    func start() {
        startCalled = true
    }
    
    func didNotifyFavedUnFavedPokemon() {
        didNotifyFavedUnFavedPokemonCalled = true
    }

}
