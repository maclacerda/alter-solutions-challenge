//
//  PokemonListCoordinatorTests.swift
//  AlterSolutionsChallengeAppTests
//
//  Created by Marcos Lacerda on 01/09/21.
//

import XCTest
@testable import AlterSolutionsChallengeApp

class PokemonListCoordinatorTests: XCTestCase {
    
    // MARK: - Properties
    
    var presenter: BaseNavigationViewController!
    var sut: PokemonListCoordinatorSpy!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()

        presenter = BaseNavigationViewController()
        sut = PokemonListCoordinatorSpy()
    }
    
    // MARK: - Tests
    
    func testListCoordinator_start_ShouldBeCalled() {
        // Given
        sut.presenter = presenter

        // When
        sut.start()
        
        // Then
        XCTAssertNotNil(sut.presenter)
        XCTAssertTrue(sut.startCalled)
    }

}

class PokemonListCoordinatorSpy: PokemonListCoordinatorProtocol, PokemonListViewControllerDelegate {

    var presenter: BaseNavigationViewController?
    var startCalled: Bool = false
    var didSelectPokemonCalled: Bool = false
    var pokemonDetailName: String = ""

    func start() {
        startCalled = true
    }
    
    func didSelectPokemon(_ pokemon: PokemonDetail) {
        didSelectPokemonCalled = true
        pokemonDetailName = pokemon.name
    }

}
