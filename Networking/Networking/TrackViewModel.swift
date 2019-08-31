//
//  TrackViewModel.swift
//  Networking
//
//  Created by Sateesh Yegireddi on 24/08/19.
//  Copyright © 2019 Company. All rights reserved.
//

import Foundation

class TrackViewModel {
    
    //MARK: - Properties -
    private var dataManager: DataManager
    private var tracks: [Track] = []
    var term = Dynamic<String?>(nil)
    var country = "IN"
    var isLoading = Dynamic<Bool>(false)
    var error = Dynamic<Field?>(nil)
    var shouldReloadData = Dynamic<Bool>(false)
    private var cellViewModels: [TrackCellViewModel] = []
    
    //MARK: - Initialisation -
    init(dataManager: DataManager = DataManager()) {
        self.dataManager = dataManager
    }
    
    //MARK: - Data and Functionality -
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    private func processTracks(_ tracks: [Track]) {
        tracks.forEach {
            let viewModel = createCellViewModel($0)
            cellViewModels.append(viewModel)
        }
    }
    
    private func createCellViewModel(_ track: Track) -> TrackCellViewModel {
        let trackCellViewModel = TrackCellViewModel(artistName: track.artistName,
                                                    artistURL: track.artworkUrl100)
        return trackCellViewModel
    }
    
    func getCellViewModel(at index: Int) -> TrackCellViewModel {
        return cellViewModels[index]
    }
}

//MARK: - Cell ViewModel -
struct TrackCellViewModel {
    var artistName: String
    var artistURL: String
    
    init(artistName: String, artistURL: String) {
        self.artistName = artistName
        self.artistURL = artistURL
    }
}

//MARK: - Networking -
extension TrackViewModel {
    private var request: MusicRequest {
        return MusicRequest(term: term.value ?? "", country: country)
    }
    
    func fetchTracks() {
        isLoading.value = true
        dataManager.fetchTracks(with: request) { [weak self] (tracks, error) in
            guard let self = self else { return }
            self.isLoading.value = false
            guard let tracks = tracks else {
                if let error = error {
                    self.error.value = error
                }
                return
            }
            self.tracks = tracks
            self.processTracks(self.tracks)
            self.shouldReloadData.value = true
        }
    }
}

struct MusicRequest: APIRequest {
    var method: HTTPMethod = .GET
    var path: EndPoint = .search
    var parameters = [EndPoint: String]()
    var body: [String : Any]? = nil
    var dispatchGroup: DispatchGroup? = nil

    init(term: String, country: String) {
        parameters[.term] = term
        parameters[.country] = country
    }
}

//https://itunes.apple.com/search?term=arrehman&country=IN
