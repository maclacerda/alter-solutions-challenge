//
//  AlterSolutionsChallengeAppExtensionsTests.swift
//  AlterSolutionsChallengeAppTests
//
//  Created by Marcos Lacerda on 29/08/21.
//

import XCTest
@testable import AlterSolutionsChallengeApp

// swiftlint:disable type_name
class AlterSolutionsChallengeAppExtensionsTests: XCTestCase {

    func testStringExtension_extractIdentifier_ShouldReturnCorrectPokemonId() {
        let sut = "https://pokeapi.co/api/v2/pokemon/1/"
        let expected = "1"
        
        XCTAssertEqual(expected, sut.extractPokemonIdentifier())
    }
    
    func testStringExtension_makeAvatarURL_ShouldReturnAValidURL() {
        let resourceURL = "https://pokeapi.co/api/v2/pokemon/1/"
        let sut = resourceURL.extractPokemonIdentifier()
        let expected = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"
        
        let avatarURL = sut.makeAvatarURL()
        
        XCTAssertEqual(expected, avatarURL)
        XCTAssertNotNil(URL(string: avatarURL))
    }
    
}
// swiftlint:enable type_name
