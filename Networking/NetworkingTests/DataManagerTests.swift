//
//  DataManagerTests.swift
//  NetworkingTests
//
//  Created by Sateesh Yegireddi on 25/08/19.
//  Copyright © 2019 Company. All rights reserved.
//

import XCTest
@testable import Networking

class DataManagerTests: XCTestCase {

    var dataManager: DataManager?
    
    override func setUp() {
        super.setUp()
        dataManager = DataManager()
    }

    override func tearDown() {
        dataManager = nil
        super.tearDown()
    }

    func testSearchTracks() {
        let expect = XCTestExpectation(description: "Callaback")
        let request = MusicRequest(term: "", country: "")
        dataManager?.fetchTracks(with: request, handler: { (tracks, error) in
            expect.fulfill()
            if let tracks = tracks {
                XCTAssertEqual(tracks.count, 3)
                tracks.forEach {
                    XCTAssertNotNil($0.trackId)
                }
            }
        })
        
        wait(for: [expect], timeout: 3.1)
    }
}
