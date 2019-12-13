//
//  Pursuit_Core_iOS_Episodes_from_OnlineTests.swift
//  Pursuit-Core-iOS-Episodes-from-OnlineTests
//
//  Created by Benjamin Stone on 9/5/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import XCTest
@testable import Pursuit_Core_iOS_Episodes_from_Online

class Pursuit_Core_iOS_Episodes_from_OnlineTests: XCTestCase {
    
    func testShowsAPI() {

        // arrange
        let searchQuery = "Good"
        let exp = XCTestExpectation(description: "shows found")


        // act
        ShowAPIClient.getShows(searchQuery: searchQuery) { (result) in
            switch result {
            case .failure(let appError):
                XCTFail("appError: \(appError)")
            case .success(let shows):
                    // assert
                    XCTAssertEqual(shows.count, 10, "data should be \(shows.count)")
                    exp.fulfill()
            }
        }
        wait(for:[exp], timeout: 5.0)
    }

    func testEpisodesAPI() {
        // arrange
        let showID = 169
        let exp = XCTestExpectation(description: "episodes found")

        // act
        EpisodeAPI.getEpisodes(episodeID: showID) { (result) in
            switch result {
            case .failure(let appError):
                XCTFail("appError: \(appError)")
            case .success(let episodesArr):
                // assert
                
                XCTAssertEqual(episodesArr.count, 62, "data should be greater then \(episodesArr.count)")
                exp.fulfill() // call end an to the closure, completion is complete

            }
        }
        wait(for:[exp], timeout: 5.0)
    }
}


