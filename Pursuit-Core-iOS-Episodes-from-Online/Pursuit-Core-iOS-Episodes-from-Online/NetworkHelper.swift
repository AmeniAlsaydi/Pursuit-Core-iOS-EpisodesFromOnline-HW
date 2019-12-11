//
//  NetworkHelper.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Amy Alsaydi on 12/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

enum AppError: Error {
    case badURL(String) // string is an asssociated value: captures a value along side the case
    case noResponse
    case networkClientError(Error)
    case noData // server could be down
    case decodingError(Error)
    case badStatusCode(Int) // 404, 500
    case badMimeType(String) // multimedia type // image/jpg
}

class NetworkHelper {
    
    static let shared = NetworkHelper()
    
    private var session: URLSession
    
    func performDataTask(with urlString: String,
                         completion: @escaping (Result<Data, AppError>) -> ()) {
       
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL(urlString)))
            return
        }
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in
      
            if let error = error {
                completion(.failure(.networkClientError(error)))
            }
           
            guard let urlResponse = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
         
            guard let data = data else {
                completion(.failure(.noData))
            return
            }
            
            switch urlResponse.statusCode {
            case 200...299: break // everything went well
            default:
                completion(.failure(.badStatusCode(urlResponse.statusCode)))
                return
            }
            
            completion(.success(data))
        }
        
        dataTask.resume()
       
    }

    
    private init() {
        session = URLSession(configuration: .default)
        
    }
}

