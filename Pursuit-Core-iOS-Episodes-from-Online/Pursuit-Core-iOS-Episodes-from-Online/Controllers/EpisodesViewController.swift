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
    
    var theShow: Show?
    
    var episodes = [Episode]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print(theShow)
        tableView.dataSource = self
        loadEpisodes()
        tableView.delegate = self
        
        

    }
    
    func loadEpisodes() {
        
        let episodeID = theShow?.show?.id ?? 1
        print(episodeID)
        EpisodeAPI.getEpisodes(episodeID: episodeID ) { (result) in
               switch result {
                     case .failure(let appError):
                         print("appError: \(appError)")
                     case .success(let episodes):
                        print(episodes.count)
                         DispatchQueue.main.async {
                             self.episodes = episodes
                            dump(episodes)
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
