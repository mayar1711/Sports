//
//  League.swift
//  SportsApp
//
//  Created by Mayar on 23/04/2024.
//

import Foundation

class League {
    let leagueKey: Int
    let leagueName: String
    let countryKey: Int
    let countryName: String
    let leagueLogo: String?
    let countryLogo: String?
    
    init(leagueKey: Int, leagueName: String, countryKey: Int, countryName: String, leagueLogo: String?, countryLogo: String?) {
        self.leagueKey = leagueKey
        self.leagueName = leagueName
        self.countryKey = countryKey
        self.countryName = countryName
        self.leagueLogo = leagueLogo
        self.countryLogo = countryLogo
    }
}



