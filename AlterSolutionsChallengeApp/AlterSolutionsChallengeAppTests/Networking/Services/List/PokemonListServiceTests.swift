//
//  PokemonListServiceTests.swift
//  AlterSolutionsChallengeAppTests
//
//  Created by Marcos Lacerda on 01/09/21.
//

import XCTest
@testable import AlterSolutionsChallengeApp

class PokemonListServiceTests: XCTestCase {

    func testListService_execute_ShouldBeCalled() {
        let sut = PokemonListServiceSpy()
        
        sut.execute(offset: 0, limit: 0) { _ in }
        
        XCTAssertTrue(sut.executeCalled)
    }

}

class PokemonListServiceSpy: PokemonListServiceProtocol {
    
    var executeCalled: Bool = false
    
    func execute(offset: Int, limit: Int, handler: @escaping ((Result<[PokemonResponse]?, ListUseCaseError>) -> Void)) {
        executeCalled = true
    }
    
}
