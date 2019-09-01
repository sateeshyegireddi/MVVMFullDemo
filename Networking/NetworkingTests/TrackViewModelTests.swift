//
//  TrackViewModelTests.swift
//  NetworkingTests
//
//  Created by Sateesh Yegireddi on 31/08/19.
//  Copyright © 2019 Company. All rights reserved.
//

import XCTest

class TrackViewModelTests: XCTestCase {

    var trackViewModel: TrackViewModel!
    var dataManager: MockDataManager!
    
    override func setUp() {
        super.setUp()
        
        dataManager = MockDataManager()
        trackViewModel = TrackViewModel(dataManager: dataManager)
    }

    override func tearDown() {
        trackViewModel = nil
        dataManager = nil
        super.tearDown()
    }

    func testFetchTracks() {
        
        //Given
        dataManager.tracks = [Track]()
        
        //When
        trackViewModel.fetchTracks()
        
        //Assert
        XCTAssert(dataManager.isDataFetched)
    }
    
    func testFetchTracksFail() {
        
        //Given
        let error = Field.noData
        
        //When
        trackViewModel.fetchTracks()
        
        dataManager.fetchWithError(error)
        
        //Assert
        XCTAssertEqual(trackViewModel.error.value?.error.domain ?? "", error.error.domain)
    }
    
    func testCreateCellViewModel() {
        
        //Given
        let response: Response<Track> = FileLoader.readDataFromFile(at: "Tracks")
        dataManager.tracks = response.data
        let tracks = dataManager.tracks
        let expectation = XCTestExpectation(description: "Reload tableView triggered")
        trackViewModel.shouldReloadData.bind { success in
            if success { expectation.fulfill() }
        }
        
        //When
        trackViewModel.fetchTracks()
        dataManager.fetchWithSuccess()
        
        //Number of cells is equal to tracks
        XCTAssertEqual(trackViewModel.numberOfCells, tracks.count)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testLoadingStatusWhileFetching() {
        
        //Given
        var loading = false
        let expectation = XCTestExpectation(description: "Loading status updated")
        trackViewModel.isLoading.bind { [weak self] (success) in
            loading = self?.trackViewModel.isLoading.value ?? false
            expectation.fulfill()
        }
        
        //When
        trackViewModel.fetchTracks()
        
        //Assert
        XCTAssert(loading)
        
        //When finished fetching
        dataManager.fetchWithSuccess()
        
        //Assert
        XCTAssertFalse(loading)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetCellViewModel() {
        
        //Given
        fetchTracksWithSuccess()
        let indexPath = IndexPath(item: 1, section: 0)
        let track = dataManager.tracks[indexPath.row]
        
        //When
        let viewModel = trackViewModel.getCellViewModel(at: indexPath)
        
        //Assert
        XCTAssertEqual(track.artistName, viewModel.artistName)
    }
    
    func testCellViewModel() {
        
        //Given Tracks
        let track = Track(trackId: 1, artistName: "Taylor Swift", artworkUrl100: "https://is4-ssl.mzstatic.com/image/thumb/Music118/v4/96/94/27/96942711-62c9-42c1-c296-2d73b2db52a9/source/100x100bb.jpg")
        let trackWithoutURL = Track(trackId: 2, artistName: "Taylor Swift", artworkUrl100: "")
        
        //When create cell view model
        let viewModel = trackViewModel.createCellViewModel(track)
        let viewModelWithoutURL = trackViewModel.createCellViewModel(trackWithoutURL)
        
        //Assert the correctness of display information
        XCTAssertEqual(track.artistName, viewModel.artistName)
        XCTAssertEqual(trackWithoutURL.artistName, viewModelWithoutURL.artistName)
    }
}

extension TrackViewModelTests {
    
    func fetchTracksWithSuccess() {
        let response: Response<Track> = FileLoader.readDataFromFile(at: "Tracks")
        dataManager.tracks = response.data
        trackViewModel.fetchTracks()
        dataManager.fetchWithSuccess()
    }
}

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
