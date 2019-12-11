//
//  ViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Benjamin Stone on 9/5/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var shows = [Show]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var searchQuery = "" {
        didSet {
            ShowAPIClient.getShows(searchQuery: searchQuery) { (result) in
                switch result {
                case .failure(let appError):
                    print("appError: \(appError)")
                case .success(let shows):
                    DispatchQueue.main.async {
                        self.shows = shows.filter{($0.show?.name.lowercased().contains(self.searchQuery.lowercased()) ?? false)}
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        searchBar.delegate = self
        //loadShows(searchQ: searchQuery)
        
    }
    
    
    
    func loadShows(searchQ: String) {
        ShowAPIClient.getShows(searchQuery: searchQ) { (result) in
            switch result {
            case .failure(let appError):
                print("appError: \(appError)")
            case .success(let shows):
                DispatchQueue.main.async {
                    self.shows = shows
                }
            }
        }
    }

}

extension ShowViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "showCell", for: indexPath) as? ShowCell else {
            fatalError("issue with dequeueReusableCell/ custom cell ")
        }
        
        let show = shows[indexPath.row]
        cell.configureCell(for: show)
        return cell
    }
    
    
}

extension ShowViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         guard !searchText.isEmpty else {
            shows = [Show]()
                   return
               }
               searchQuery = searchText
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

