//
//  ShowCell.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Amy Alsaydi on 12/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ShowCell: UITableViewCell {
    
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    
    func configureCell(for theShow: Show) {
        
        titleLabel.text = theShow.show?.name
        ratingLabel.text = theShow.show?.rating?.average?.description ?? "No Rating"
        
        // images are not secure so they dont load "http" 
        guard let mediumImageURL = theShow.show?.image?.medium else {
            return
            // fatalError("no medium image for show \(theShow.show?.name ?? "xyz")")
        }
        // let originalImageURL = theShow.show?.image?.original
        
        NetworkHelper.shared.performDataTask(with: mediumImageURL) { (result) in
            switch result {
            case .failure(let appError):
                print("appError: \(appError)")
            case .success(let data):
                let image = UIImage(data: data)
                
                DispatchQueue.main.async {
                    self.showImage.image = image
                }
            }
        }
    }
    
}
