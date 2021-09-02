//
//  PokemonDetailServiceTests.swift
//  AlterSolutionsChallengeAppTests
//
//  Created by Marcos Lacerda on 01/09/21.
//

import XCTest
@testable import AlterSolutionsChallengeApp

class PokemonDetailServiceTests: XCTestCase {

    func testDetailService_execute_ShouldBeCalled() {
        let sut = PokemonDetailServiceSpy()
        
        sut.execute(with: "") { _ in }
        
        XCTAssertTrue(sut.executeCalled)
    }

}

class PokemonDetailServiceSpy: PokemonDetailServiceProtocol {
    
    var executeCalled: Bool = false
    
    func execute(with identifier: String, handler: @escaping ((Result<PokemonDetailResponse?, DetailUseCaseError>) -> Void)) {
        executeCalled = true
    }
    
}
