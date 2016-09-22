//
//  SearchTableViewController.swift
//  Spotify Artists Viewer
//
//  Created by Asaph Yuan on 9/22/16.
//  Copyright © 2016 Asaph Yuan. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate  {
    var searchResults = ["Muse"]
    var searchController: UISearchController!
    let requestManager = RequestManager()
    override func viewDidLoad() {
        title = "Search Spotify Artists"
        configureSearchController()
    }
    
    private func configureSearchController()
    {
        // Initialize and perform a minimum configuration to the search controller.
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search here..."
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        
        // Place the search bar view to the tableview headerview.
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        //call search
        if let searchText = searchController.searchBar.text {
            requestManager.getArtistsWithQuery(query: searchText, completion: {results, err in
                guard let results = results else { return }
                for artist in results {
                    self.searchResults.append(artist.name)
                }
                self.tableView.reloadData()
            })
            tableView.reloadData()
        }
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistCell", for: indexPath)
        if let cellTextLabel = cell.textLabel {
            cellTextLabel.text = searchResults[indexPath.row]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let artistVC = segue.destination as? ArtistViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                artistVC.query = searchResults[indexPath.row]
            }
        }
    }

}
