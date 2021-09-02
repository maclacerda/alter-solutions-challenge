//
//  PokemonListViewModelTests.swift
//  AlterSolutionsChallengeAppTests
//
//  Created by Marcos Lacerda on 01/09/21.
//

import XCTest
import RxSwift
@testable import AlterSolutionsChallengeApp

class PokemonListViewModelTests: XCTestCase {
    
    // MARK: - Properties
    var homeCoordinatorSpy: PokemonListCoordinatorSpy!

    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
    
        AlterSolutionsChallengeAppDependencies.registerDependencies()
        homeCoordinatorSpy = PokemonListCoordinatorSpy()
    }
    
    // MARK: - Tests
    
    func testInit() {
        // Given
        var sut: PokemonListViewModel
        
        // When
        sut = PokemonListViewModel()
        sut.delegate = self

        // Then

        XCTAssertNotNil(sut, "invalid viewModel instance")
        XCTAssertNotNil(sut.delegate, "PokemonListViewModelDelegate was not set")
        XCTAssertTrue(sut.pokemons.isEmpty)
    }
    
    func testShowItemDetailsForSelectedCellModelCalledWithValidPokemonCellModel() {
        // Given
        guard let listResponse = try? JSONDecoder().decode([PokemonResponse].self, from: MockDataHelper.getData(forResource: .pokemonList)),
              let bulbassaurListResult = listResponse.first else {
            XCTFail("Could not prepare test case.")
            return
        }

        let sut = PokemonListViewModel()
        sut.delegate = self
        
        sut.pokemons.append(Pokemon(
                                name: bulbassaurListResult.name,
                                photo: bulbassaurListResult.url.extractPokemonIdentifier().makeAvatarURL(),
                                isFaved: false)
        )
        
        // When
        sut.showDetailsForPokemon(with: 0)
        
        // Then
        XCTAssertTrue(homeCoordinatorSpy.didSelectPokemonCalled, "didSelectPokemon() was not called")
        XCTAssertEqual(homeCoordinatorSpy.pokemonDetailName.lowercased(), bulbassaurListResult.name)
    }
    
    func testShowItemDetailsForSelectedCellModelCalledWithInvalidPokemonCellModel() {
        // Given
        let pokemonListItem = PokemonResponse(name: "", url: "url")
        let sut = PokemonListViewModel()
        
        sut.pokemons.append(Pokemon(name: pokemonListItem.name, photo: pokemonListItem.url, isFaved: false))
        
        // When
        sut.showDetailsForPokemon(with: 0)
        
        // Then
        XCTAssertFalse(homeCoordinatorSpy.didSelectPokemonCalled, "didSelectPokemon() was called")
        XCTAssertTrue(homeCoordinatorSpy.pokemonDetailName.isEmpty)
    }

}

extension PokemonListViewModelTests: PokemonListViewModelDelegate {

    func showDetailsForPokemon(with pokemon: PokemonDetail) {
        homeCoordinatorSpy.didSelectPokemon(pokemon)
    }

}
