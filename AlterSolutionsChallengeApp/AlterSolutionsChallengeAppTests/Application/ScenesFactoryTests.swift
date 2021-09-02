//
//  ScenesFactoryTests.swift
//  AlterSolutionsChallengeAppTests
//
//  Created by Marcos Lacerda on 01/09/21.
//

import XCTest
@testable import AlterSolutionsChallengeApp

class ScenesFactoryTests: XCTestCase {

    // MARK: - Properties

    let sut = ScenesFactory()

    // MARK: Tests

    func testBuildListModule() {
        // When
        let controller = sut.makePokemonList()
        
        // Then
        XCTAssertNotNil(controller)
    }
    
    func testBuildDetailModule() {
        let pokemonMock = Pokemon(name: "Name", photo: "Photo", isFaved: false)
        let mock = PokemonDetail(pokemon: pokemonMock)
        
        // When
        let controller = sut.makePokemonDetail(with: mock)
        
        // Then
        XCTAssertNotNil(controller)
    }

}
