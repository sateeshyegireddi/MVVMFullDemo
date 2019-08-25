//
//  APIServiceTests.swift
//  MVVMPlaygroundTests
//
//  Created by Neo on 01/10/2017.
//  Copyright © 2017 ST.Huang. All rights reserved.
//

import XCTest
@testable import MVVMPlayground

class APIServiceTests: XCTestCase {
    
    var sut: APIService?
    
    override func setUp() {
        super.setUp()
        sut = APIService()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_fetch_popular_photos() {

        // Given A apiservice
        let sut = self.sut!

        let expect = XCTestExpectation(description: "Callback")
        
        sut.fetchPopularPhoto { (success, photos, error) in
            expect.fulfill()
            XCTAssertEqual(photos.count, 20)
            photos.forEach { XCTAssertNotNil($0.id) }
        }
        
        wait(for: [expect], timeout: 3.1)
    }
    
}
