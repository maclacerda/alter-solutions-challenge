//
//  PokemonDetailViewModelTests.swift
//  AlterSolutionsChallengeAppTests
//
//  Created by Marcos Lacerda on 01/09/21.
//

import XCTest
import AlterSolutionsChallengeCore
@testable import AlterSolutionsChallengeApp

class PokemonDetailViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var detailsCoordinatorSpy: PokemonDetailCoordinatorSpy!
    var imageDownloader: ImageDownloaderProtocol!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        
        AlterSolutionsChallengeAppDependencies.registerDependencies()
        
        detailsCoordinatorSpy = PokemonDetailCoordinatorSpy()
        imageDownloader = ImageDownloadStub()
    }
    
    // MARK: - Tests
    
    func testActOnFavoritesButtonTouch_AddingFavorite() {
        // Given
        let sut = PokemonDetailViewModel(with: PokemonDetail(pokemon: Pokemon(name: "bulbassaur", photo: "")))
        
        // When
        sut.updatePokemonFavedStatus()
        
        // Then
        XCTAssertTrue(sut.isFaved())
    }
    
    func testActOnFavoritesButtonTouch_RemovingFavorite() {
        // Given
        let sut = PokemonDetailViewModel(with: PokemonDetail(pokemon: Pokemon(name: "bulbassaur", photo: "")))
        
        // When
        sut.updatePokemonFavedStatus()
        
        // Then
        XCTAssertFalse(sut.isFaved())
    }

}
