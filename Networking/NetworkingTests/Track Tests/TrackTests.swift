//
//  TrackTests.swift
//  NetworkingTests
//
//  Created by Sateesh Yegireddi on 01/09/19.
//  Copyright © 2019 Company. All rights reserved.
//

import XCTest

class TrackTests: XCTestCase {

    var tracks: [Track]!
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testTrackModel() {
        
        //Given
        let response: Response<Track> = FileLoader.readDataFromFile(at: "Tracks")
        tracks = response.data

        //When
        let track = tracks[0]
        
        //Assert
        XCTAssertEqual(tracks.count, 50)
        XCTAssertEqual(track.artistName, "Qari Waheed Zafar")
    }
}
