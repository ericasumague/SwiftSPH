//
//  MockURLSessionDataTask.swift
//  SPHTechExamTests
//
//  Created by Erica on 24/08/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import Foundation
import XCTest

class MockURLSessionDataTask : URLSessionDataTask {
    
    var resumeExpectation: XCTestExpectation?
    var completionHandler:((Data?, URLResponse?, Error?) -> Swift.Void)?
    var dataToReturn:Data?
    var urlResponseToReturn:URLResponse?
    var errorToReturn:Error?
    
    override func resume() {
        resumeExpectation?.fulfill()
        if let
            completionHandler = completionHandler
        {
            DispatchQueue.main.asyncAfter(
            deadline: .now() + 0.1) {
                completionHandler(
                    self.dataToReturn,
                    self.urlResponseToReturn,
                    self.errorToReturn)
                
                self.dataTaskToReturn?.completionHandler =
                completionHandler
            }
        }
    }
}
