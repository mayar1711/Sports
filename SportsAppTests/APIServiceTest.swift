//
//  APIServiceTest.swift
//  SportsAppTests
//
//  Created by Mayar on 30/04/2024.
//

import XCTest
@testable import SportsApp

final class APIServiceTest: XCTestCase {

    func testFetchLeagues() {
        let expectation = self.expectation(description: "Fetching leagues")
        
        APIService.shared.fetchLeagues(forSport: "football") { leagues, error in
            
            if let leagues = leagues {
                XCTAssertNotNil(leagues, "Leagues should not be nil")
                expectation.fulfill()
            } else {
                XCTFail()
                //XCTAssertNil(leaguesResponse, "Response should be nil")

            }
        }
        waitForExpectations(timeout: 10)
    }
    
}
