//
//  DetailViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Amy Alsaydi on 12/11/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var seasonNum: UILabel!
    @IBOutlet weak var episodeNum: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    
    var episode: Episode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    
    }
    
    func updateUI() {
        
        guard let theEpisode = episode else {
            fatalError("segue issue")
        }
        
        nameLabel.text = theEpisode.name
        seasonNum.text = "Season: \(theEpisode.season)"
        episodeNum.text = "Episode: \(theEpisode.number)"
        summaryLabel.text = theEpisode.summary?.replacingOccurrences(of: "<p>",with: "").replacingOccurrences(of: "</p>",with: "")
        
        let imageURL = theEpisode.image?.original ?? "none"
        
         NetworkHelper.shared.performDataTask(with: imageURL) { (result) in
                   switch result {
                   case .failure(let appError):
                       print("appError: \(appError)")
                   case .success(let data):
                       let image = UIImage(data: data)
                       
                       DispatchQueue.main.async {
                           self.imageView.image = image
                       }
                   }
        
        
        
        
    }
    

}

}
