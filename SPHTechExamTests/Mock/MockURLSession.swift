//
//  MockURLSession.swift
//  SPHTechExamTests
//
//  Created by Erica on 24/08/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import Foundation
import XCTest

class MockURLSession : URLSessionProtocol {
    
    var dataTaskExpectation: (XCTestExpectation, expectedURL:URL)?
    var dataTaskToReturn:MockURLSessionDataTask?
    
    init() {
        self.dataTaskToReturn =
            MockURLSessionDataTask()
    }
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        if let (expectation, expectedValue) =
            self.dataTaskExpectation {
            if    expectedValue.absoluteString.compare(
                url.absoluteString) == .orderedSame {
                expectation.fulfill()
            }
        }
        return self.dataTaskToReturn!
    }
    
}
