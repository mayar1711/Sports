//
//  LeagueDetails.swift
//  SportsApp
//
//  Created by Shimaa on 26/04/2024.
//

import Foundation

class LeagueDetails: Decodable{
    let eventKey: Int?
    let eventDay: String?
    let eventTime: String?
    let eventHomeTeam: String?
    let homeTeamKey: Int?
    let eventAwayTeam: String?
    let awayTeamKey: Int?
    let eventHalftimeResult: String?
    let leagueLogo: String?
    let homeTeamLogo: String?
    let awayTeamLogo: String?
    let leagueKey: Int?
    let leagueName: String?
    let eventStadium: String?
    let leagueSeason: String?
    let finalResult: String?
    
    enum CodingKeys: String, CodingKey{
        case eventKey = "event_key"
        case eventDay = "event_date"
        case eventTime = "event_time"
        case eventHomeTeam = "event_home_team"
        case homeTeamKey = "home_team_key"
        case eventAwayTeam = "event_away_team"
        case awayTeamKey = "away_team_key"
        case eventHalftimeResult = "event_halftime_result"
        case leagueLogo = "league_logo"
        case homeTeamLogo = "home_team_logo"
        case awayTeamLogo = "away_team_logo"
        case leagueName = "league_name"
        case leagueKey = "league_key"
        case eventStadium = "event_stadium"
        case leagueSeason = "league_season"
        case finalResult = "event_final_result"
    }
}


class LeagueDetailsResponse: Decodable{
    let success: Int
    let result: [LeagueDetails]
}

