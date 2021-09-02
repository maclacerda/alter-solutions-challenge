//
//  PokemonDetailRequestTests.swift
//  AlterSolutionsChallengeAppTests
//
//  Created by Marcos Lacerda on 01/09/21.
//

import XCTest
import AlterSolutionsChallengeCore
@testable import AlterSolutionsChallengeApp

class PokemonDetailRequestTests: XCTestCase {

    func testPokemonDetailRequest_pokemonDetail_ShouldBeReturnCorrectURL() {
        let sut = PokemonDetailRequest.detail(pokemon: "pikachu")
        SecurityManager.shared.salt = Constants.salt
        
        XCTAssertEqual(sut.baseURL.absoluteString, try? SecurityManager.shared.reveal(Constants.baseURL))
        XCTAssertEqual(sut.method, .get)
        XCTAssertNotNil(sut.headers)
        XCTAssertEqual(sut.headers!["Content-Type"] as? String, "application/json")
        XCTAssertNil(sut.parameters)
        XCTAssertEqual(sut.path, "pokemon/pikachu")
    }

}
