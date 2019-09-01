//
//  MockDataManager.swift
//  NetworkingTests
//
//  Created by Sateesh Yegireddi on 01/09/19.
//  Copyright © 2019 Company. All rights reserved.
//

import Foundation

class MockDataManager {
    var tracks = [Track]()
    var isDataFetched = false
    var handler: (([Track]?, Field?) -> ())!
    
    func fetchWithSuccess() {
        handler(tracks, nil)
    }
    
    func fetchWithError(_ error: Field?) {
        handler(nil, error)
    }
}

extension MockDataManager: FetchTracks {
    func fetchTracks(with request: APIRequest, handler: @escaping ([Track]?, Field?) -> ()) {
        isDataFetched = true
        self.handler = handler
    }
}
