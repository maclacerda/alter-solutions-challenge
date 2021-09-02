//
//  PokemonFavedListServiceTests.swift
//  AlterSolutionsChallengeAppTests
//
//  Created by Marcos Lacerda on 01/09/21.
//

import XCTest
@testable import AlterSolutionsChallengeApp

class PokemonFavedListServiceTests: XCTestCase {

    func testFavedService_execute_ShouldBeCalled() {
        let sut = PokemonFavedListServiceSpy()
        
        let result = sut.execute()
        
        XCTAssertTrue(sut.executeCalled)
        XCTAssertTrue(result.isEmpty)
    }

}

class PokemonFavedListServiceSpy: PokemonFavedListServiceProtocol {
    
    var executeCalled: Bool = false
    
    func execute() -> [Pokemon] {
        executeCalled = true
        return []
    }
    
}
