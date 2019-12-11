//
//  EpisodesViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Amy Alsaydi on 12/11/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class EpisodesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var show: Show?
    
    var episodes = [Episode]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadEpisodes(theShow: show!)
        tableView.delegate = self
        

    }
    
    func loadEpisodes(theShow: Show) {
        
        let episodeID = theShow.show?.id ?? 0
        EpisodeAPI.getEpisodes(episodeID: episodeID ) { (result) in
               switch result {
                     case .failure(let appError):
                         print("appError: \(appError)")
                     case .success(let episodes):
                         DispatchQueue.main.async {
                             self.episodes = episodes
                         }
                     }
        }
    }
    


}

extension EpisodesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as? EpisodeCell else {
            fatalError("issue with dequeueReusableCell/ custom cell")
        }
        
        let episode = episodes[indexPath.row]
        
        cell.configureCell(for: episode)
        return cell
    }
    
    
}

extension EpisodesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
