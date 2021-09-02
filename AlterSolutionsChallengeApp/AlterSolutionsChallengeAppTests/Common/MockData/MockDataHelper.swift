//
//  MockDataHelper.swift
//  AlterSolutionsChallengeAppTests
//
//  Created by Marcos Lacerda on 01/09/21.
//

import Foundation

final class MockDataHelper {

    // MARK: Enums

    enum MockedResource: String {
        case bulbassaur
        case pokemonList
    }
    
    // MARK: Helpers
    
    static func getData(forResource resource: MockedResource) -> Data {
        let bundle = Bundle(for: self)

        guard let path = bundle.path(forResource: resource.rawValue, ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            fatalError("Resource not found")
        }

        return data
    }

}
