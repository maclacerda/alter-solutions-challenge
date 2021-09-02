//
//  ListUseCaseTests.swift
//  AlterSolutionsChallengeAppTests
//
//  Created by Marcos Lacerda on 01/09/21.
//

import XCTest
import RxSwift
@testable import AlterSolutionsChallengeApp

class ListUseCaseTests: XCTestCase {
    
    func testListUseCase_execute_ShouldBeCalledAndReturnSuccess() {
        let sut = ListUseCaseSpy()
        sut.returnError = false
        
        _ = sut.execute(offset: 0, limit: 0)
        
        XCTAssertTrue(sut.executeCalled)
    }
    
    func testListUseCase_execute_ShouldBeCalledAndReturnError() {
        let sut = ListUseCaseSpy()
        sut.returnError = true
        
        _ = sut.execute(offset: 0, limit: 0)
        
        XCTAssertTrue(sut.executeCalled)
    }

}

class ListUseCaseSpy: ListUseCaseProtocol {
    
    var executeCalled: Bool = false
    var returnError: Bool = false
    
    func execute(offset: Int, limit: Int) -> Observable<Result<[PokemonResponse]?, ListUseCaseError>> {
        executeCalled = true
        
        return Observable.create { observable in
            if !self.returnError {
                observable.onNext(.success([]))
                observable.onCompleted()
            } else {
                observable.onNext(.failure(ListUseCaseError.error("Error test")))
                observable.onCompleted()
            }

            return Disposables.create()
        }
    }
    
}
