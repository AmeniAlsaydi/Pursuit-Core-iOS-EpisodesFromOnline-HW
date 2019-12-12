//
//  EpisodeCell.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Amy Alsaydi on 12/11/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class EpisodeCell: UITableViewCell {
    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var seasonEpisodeLabel: UILabel!
    
    
    func configureCell(for episode: Episode) {
        nameLabel.text = episode.name
        seasonEpisodeLabel.text = "Season: \(episode.season) Episode: \(episode.number)"
        
        let mediumImageUrl = episode.image?.medium ?? "no"
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .orange
        activityIndicator.startAnimating() // it's hidden until we explicitly start animating
        activityIndicator.center = center
        addSubview(activityIndicator) // we add the indicattor as a subview of the image view
        
        NetworkHelper.shared.performDataTask(with: mediumImageUrl) { [weak activityIndicator] (result) in
            DispatchQueue.main.async {
              activityIndicator?.stopAnimating() // hides when we stop animating the indicator
            }
            switch result {
            case .failure(let appError):
                print("appError: \(appError)")
            case .success(let data):
                let image = UIImage(data: data)
                
                DispatchQueue.main.async {
                    self.episodeImage.image = image
                }
            }
        }
    }
    
}

