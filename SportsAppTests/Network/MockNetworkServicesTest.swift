//
//  MockNetworkServicesTest.swift
//  SportsAppTests
//
//  Created by Mayar on 01/05/2024.
//

import XCTest
@testable import SportsApp

final class MockNetworkServicesTest: XCTestCase {

  
    func testFetchLeaguesSuccess() {
        let mockNetworkServices = MockNetworkServices(shouldResultError: false)
        
        let expectation = self.expectation(description: "Fetching leagues")
        
        mockNetworkServices.fetchLeagues(forSport: "football") { leagues, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            } else {
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5)
    }

    func testFetchLeaguesError() {
        let mockNetworkServices = MockNetworkServices(shouldResultError: true)
        let expectation = self.expectation(description: "Fetching leagues")
        mockNetworkServices.fetchLeagues(forSport: "football") { _, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            } else {
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5)
    }

    
}
