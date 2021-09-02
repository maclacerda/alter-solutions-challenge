//
//  URLSession+extensions.swift
//  AlterSolutionsChallengeAppUITests
//
//  Created by Marcos Lacerda on 02/09/21.
//

import Foundation

extension URLSession {

    internal static var currentMocks = [Data?]()

    /**
     The next call matching `expression` will successfully return `body`
     - parameter expression: The regular expression to compare incoming requests against
     - parameter body: The data returned by the method.
     */
    @discardableResult
    public class func mockNext(expression: String, body: Data?) -> (statusCode: Int, body: Data?) {
        currentMocks.append(body)
        return (statusCode: 200, body: body)
    }
    
    /**
     Remove all mocks
     */
    public class func removeAllMocks() {
        currentMocks.removeAll()
    }

}
