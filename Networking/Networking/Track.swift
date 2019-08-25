//
//  Track.swift
//  iOSConcepts
//
//  Created by Sateesh Yegireddi on 24/08/19.
//  Copyright © 2019 Company. All rights reserved.
//

import Foundation

struct Response: Codable {
    var resultCount: Int
    var tracks: [Track]
    
    enum CodingKeys: String, CodingKey {
        case resultCount = "resultCount"
        case tracks = "results"
    }
}

struct Track: Codable {
    var trackId: Int
    var artistName: String
    var artworkUrl100: String
}
