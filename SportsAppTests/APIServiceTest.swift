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

    func testFetchTeam() {
        let expectation = self.expectation(description: "Fetching team")
        
        APIService.shared.fetchTeam(forSport: "football", forId: 123) { team, error in
            if let team = team {
                
                XCTAssertNotNil(team, "Team should not be nil")
                expectation.fulfill()

            }
            else {
                XCTFail()
            }
        }
        waitForExpectations(timeout: 10) { error in
        }
     }
    
    func testFetchLeaguesDetail() {
        let expectation = self.expectation(description: "Fetching LeaguesDetail")

        APIService.shared.fetchLeaguesDetails(forSport: "football", forLeagueDetail: 270, from: "2024-01-01", to: "2024-12-31") { leagueDetails, error in
            if let leagueDetails = leagueDetails {
                XCTAssertNotNil(leagueDetails, "League details should not be nil")
                expectation.fulfill()
            } else {
                XCTFail("Failed to fetch league details")
            }
        }

        waitForExpectations(timeout: 20) { error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
    }


    
    
}
