//
//  Track.swift
//  iOSConcepts
//
//  Created by Sateesh Yegireddi on 24/08/19.
//  Copyright © 2019 Company. All rights reserved.
//

import Foundation

struct Response<T: Codable>: Codable {
    var resultCount: Int
    var data: [T]
    
    enum CodingKeys: String, CodingKey {
        case resultCount = "resultCount"
        case data = "results"
    }
}

struct Track: Codable {
    var trackId: Int
    var artistName: String
    var artworkUrl100: String
}
