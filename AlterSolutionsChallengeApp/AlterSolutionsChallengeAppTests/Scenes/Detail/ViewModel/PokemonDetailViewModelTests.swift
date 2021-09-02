//
//  PokemonDetailViewModelTests.swift
//  AlterSolutionsChallengeAppTests
//
//  Created by Marcos Lacerda on 01/09/21.
//

import XCTest
@testable import AlterSolutionsChallengeApp

class PokemonDetailViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var detailsCoordinatorSpy: PokemonDetailCoordinatorSpy!
    var imageDownloader: ImageDownloaderProtocol!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        
        detailsCoordinatorSpy = PokemonDetailCoordinatorSpy()
        imageDownloader = ImageDownloadStub()
    }
    
    // MARK: - Tests
    
    func testActOnFavoritesButtonTouch_AddingFavorite() {
        // Given
        let sut = PokemonDetailViewModel(with: PokemonDetail(pokemon: Pokemon(name: "bulbassaur", photo: "", isFaved: false)))
        
        // When
        sut.pokemonDetail.isFaved = !sut.pokemonDetail.isFaved
        
        // Then
        XCTAssertTrue(sut.pokemonDetail.isFaved)
    }
    
    func testActOnFavoritesButtonTouch_RemovingFavorite() {
        // Given
        let sut = PokemonDetailViewModel(with: PokemonDetail(pokemon: Pokemon(name: "bulbassaur", photo: "", isFaved: true)))
        
        // When
        sut.pokemonDetail.isFaved = !sut.pokemonDetail.isFaved
        
        // Then
        XCTAssertFalse(sut.pokemonDetail.isFaved)
    }

}
