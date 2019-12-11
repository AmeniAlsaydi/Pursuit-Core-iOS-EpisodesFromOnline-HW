//
//  Show.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Amy Alsaydi on 12/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct Show: Decodable {
    let show: ShowInfo?
}

struct ShowInfo: Decodable {
    let id: Int
    let name: String
    let rating: Rating?
    let image: Image?
}

struct Image: Decodable {
    let medium: String
    let original: String 
    
}

struct Rating: Decodable {
    let average: Double?
}


