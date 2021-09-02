//
//  PokemonListRequestTests.swift
//  AlterSolutionsChallengeAppTests
//
//  Created by Marcos Lacerda on 01/09/21.
//

import XCTest
import AlterSolutionsChallengeCore
@testable import AlterSolutionsChallengeApp

class PokemonListRequestTests: XCTestCase {
    
    func testPokemonListRequest_pokemonList_ShouldBeReturnCorrectURL() {
        let sut = PokemonListRequest.pokemonList(offset: 0, limit: 10)
        SecurityManager.shared.salt = Constants.salt
        
        XCTAssertEqual(sut.baseURL.absoluteString, try? SecurityManager.shared.reveal(Constants.baseURL))
        XCTAssertEqual(sut.method, .get)
        XCTAssertNotNil(sut.headers)
        XCTAssertEqual(sut.headers!["Content-Type"] as? String, "application/json")
        XCTAssertNotNil(sut.parameters)
        XCTAssertEqual(sut.path, "pokemon")
    }
    
}
