//
//  ShowAPI.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Amy Alsaydi on 12/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct ShowAPIClient {
    static func getShows(searchQuery: String, completion: @escaping (Result<[ShowData], AppError>)-> ()){
        
        let searchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let endpointUrlString = "https://api.tvmaze.com/search/shows?q=\(searchQuery ?? "me")"
        
        NetworkHelper.shared.performDataTask(with: endpointUrlString) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let shows = try JSONDecoder().decode([ShowData].self, from: data)
                    completion(.success(shows))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
    }
}
