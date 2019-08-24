//
//  RequestServiceTest.swift
//  SPHTechExamTests
//
//  Created by Erica on 24/08/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import XCTest

class RequestServiceTest: XCTestCase {
    
    let invalidURL: String = ""
    let validURL: String = "https://data.gov.sg/api/action/datastore_search?resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f"

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testSendRequest_nilURL_fails_WithErrorCode101() {
        let expectation = self.expectation(description: "Expected failure block to be called with error code = 101")
        let request = RequestService()
        
        request.sendRequest(urlString: nil, success: { (status) in
            
        }) { (error) in
            if error._code == 101 {
                expectation.fulfill()
            }
        }
        
        self.waitForExpectations(timeout: 1.0,
                                 handler: nil)
    }

}
