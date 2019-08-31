//
//  ViewController.swift
//  Networking
//
//  Created by Sateesh Yegireddi on 24/08/19.
//  Copyright © 2019 Company. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Outlets -
    @IBOutlet weak var tracksTableView: UITableView!
    
    //MARK: - Properties -
    private var viewModel = TrackViewModel()
    lazy var searchBar = UISearchBar(frame: .zero)
    lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        return searchController
    }()
    
    //MARK: - Views -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup navigation bar
        navigationItem.title = "Artists"
        navigationItem.largeTitleDisplayMode = .automatic
        self.navigationController?.navigationBar.prefersLargeTitles = true

        //***************************************************************************//
        //*************************        Search Bar           *********************//
        //*************************        Navigation           *********************//
        //***************************************************************************//
        //Setup searchBar
//        searchBar.placeholder = "Search artist"
//        searchBar.delegate = self
//        navigationItem.titleView = searchBar

        //***************************************************************************//
        //*************************        Navigation           *********************//
        //*************************        Search Bar           *********************//
        //***************************************************************************//
        //Setup searchBar
        navigationItem.searchController = searchController
        navigationItem.searchController?.searchBar.delegate = self
        
        //Register cells
        tracksTableView.register(cellType: TrackCell.self)
        
        bindingUI()
    }
    
    //MARK: - API calling -
    private func getData() {
        viewModel.fetchTracks()
    }
    
    //MARK: - UI Binding -
    private func bindingUI() {
        viewModel.isLoading.bind { [unowned self] (isLoading) in
            if isLoading { self.presentActivity() }
            else { self.dismissActivity() }
        }
        
        viewModel.error.bind { [unowned self] (field) in
            self.presentAlert(with: field)
        }
        
        viewModel.shouldReloadData.bind { [unowned self] (shouldReloadData) in
            DispatchQueue.main.async {
                self.tracksTableView.reloadData()
            }
        }
    }
    
    deinit {
        print("ViewController released..!!")
    }
}

//MARK:  - UISearchBar Delegate -
extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.term.value = searchBar.text ?? ""
        searchBar.endEditing(true)
        searchController.dismiss(animated: true, completion: nil)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        getData()
    }
}

//MARK: - UITableView DataSource -
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: TrackCell.self, for: indexPath)
        cell.viewModel = viewModel.getCellViewModel(at: indexPath.row)
        return cell
    }
}

//MARK: - UITableView Delegate -
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ViewController: ActivityPresentable, ErrorPresentable {}
