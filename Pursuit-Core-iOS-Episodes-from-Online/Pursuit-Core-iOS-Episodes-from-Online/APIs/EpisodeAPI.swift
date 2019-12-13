//
//  EpisodeAPI.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Amy Alsaydi on 12/11/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct EpisodeAPI {
    static func getEpisodes(episodeID: Int, completion: @escaping (Result<[Episode], AppError>)-> ()) {
        let endpointUrlString = "http://api.tvmaze.com/shows/\(episodeID)/episodes" 
    
        NetworkHelper.shared.performDataTask(with: endpointUrlString) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let episodes = try JSONDecoder().decode([Episode].self, from: data)
                    print("episodes count \(episodes.count)")
                    completion(.success(episodes))

                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
