//
//  ShowAPI.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Amy Alsaydi on 12/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct ShowAPI {
    static func getShows(searchQuery: String, completion: @escaping (Result<[Show], AppError>)-> ()){
        let endpointUrlString = "http://api.tvmaze.com/search/shows?q=\(searchQuery)"
        
        NetworkHelper.shared.performDataTask(with: endpointUrlString) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let shows = try JSONDecoder().decode([Show].self, from: data)
                    completion(.success(shows))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
    }
}
