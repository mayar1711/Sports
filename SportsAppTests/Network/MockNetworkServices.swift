//
//  MockNetworkServices.swift
//  SportsAppTests
//
//  Created by Mayar on 30/04/2024.
//

import Foundation
@testable import SportsApp

class MockNetworkServices {
    
    var shouldResultError: Bool
    
    init(shouldResultError: Bool) {
        self.shouldResultError = shouldResultError
    }
    
    let LeaguesFakeJsonObj: [String: Any] = [
        "success": 1,
        "result": [
            [
                "league_key": 4,
                "league_name": "UEFA Europa League",
                "country_key": 1,
                "country_name": "eurocups",
                "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/",
                "country_logo": nil
            ]
        ]
    ]
    
    let teamFakeJsonObj: [String: Any] = [
        "success": 1,
        "result": [
            [
                "team_key": 72,
                "team_name": "Bayern Munich",
                "team_logo": "https://apiv2.allsportsapi.com/logo/72_bayern-munich.jpg",
                "players": [
                    [
                        "player_key": 3333345663,
                        "player_image": "https://apiv2.allsportsapi.com/logo/players/9689_h-kane.jpg",
                        "player_name": "H. Kane",
                        "player_number": "9",
                        "player_country": nil,
                        "player_type": "Forwards",
                        "player_age": "30",
                        "player_match_played": "31",
                        "player_goals": "35",
                        "player_yellow_cards": "2",
                        "player_red_cards": "0",
                        "player_injured": "No",
                        "player_substitute_out": "5",
                        "player_substitutes_on_bench": "0",
                        "player_assists": "8",
                        "player_birthdate": "1993-07-28",
                        "player_is_captain": "0",
                        "player_shots_total": "106",
                        "player_goals_conceded": "0",
                        "player_fouls_committed": "10",
                        "player_tackles": "13",
                        "player_blocks": "4",
                        "player_crosses_total": "30",
                        "player_interceptions": "6",
                        "player_clearances": "14",
                        "player_dispossesed": "43",
                        "player_saves": "",
                        "player_inside_box_saves": "",
                        "player_duels_total": "229",
                        "player_duels_won": "101",
                        "player_dribble_attempts": "52",
                        "player_dribble_succ": "21",
                        "player_pen_comm": "",
                        "player_pen_won": "",
                        "player_pen_scored": "4",
                        "player_pen_missed": "0",
                        "player_passes": "606",
                        "player_passes_accuracy": "448",
                        "player_key_passes": "29",
                        "player_woordworks": "",
                        "player_rating": "7.74"
                    ]
                ],
                "coaches": [
                    [
                        "coach_name": "C. Streich",
                        "coach_country": nil,
                        "coach_age": nil
                    ]
                ]
            ]
        ]
    ]
    
    let LeaguesDetailFakeJsonObj: [String: Any] = [
        "success": 1,
        "result": [
            [
                "event_key": 1243302,
                "event_date": "2024-04-26",
                "event_time": "20:45",
                "event_home_team": "Frosinone",
                "home_team_key": 5000,
                "event_away_team": "Salernitana",
                "away_team_key": 5012,
                "event_halftime_result": "2 - 0",
                "event_final_result": "3 - 0",
                "event_ft_result": "3 - 0",
                "event_penalty_result": "",
                "event_status": "Finished",
                "country_name": "Italy",
                "league_name": "Serie A",
                "league_key": 207,
                "league_round": "Round 34",
                "league_season": "2023/2024",
                "event_live": "0",
                "event_stadium": "Stadio Benito Stirpe (Frosinone)",
                "event_referee": "F. Fourneau",
                "home_team_logo": "https://apiv2.allsportsapi.com/logo/5000_frosinone.jpg",
                "away_team_logo": "https://apiv2.allsportsapi.com/logo/5012_salernitana.jpg",
                "event_country_key": 5,
                "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/207_serie-a.png",
                "country_logo": "https://apiv2.allsportsapi.com/logo/logo_country/5_italy.png",
                "event_home_formation": "3-4-1-2",
                "event_away_formation": "3-4-3",
                "fk_stage_key": 331,
                "stage_name": "Current",
                "league_group": nil,
                "goalscorers": [],
                "substitutes": [],
                "cards": [],
                "vars": [:],
                "lineups": [:],
                "statistics": []
            ]
        ]
    ]
    
    

    
}

extension MockNetworkServices{
    
    func fetchLeagues(forSport sport: String, completion: @escaping ([League]?, Error?) -> Void) {
        if sport == "invalid_sport" {
            completion(nil, NSError(domain: "MockNetworkServicesError", code: -1, userInfo: nil))
            return
        }
        guard let jsonData = try? JSONSerialization.data(withJSONObject: LeaguesFakeJsonObj) else {
            completion(nil, NSError(domain: "MockNetworkServicesError", code: -1, userInfo: nil))
            return
        }
        
        do {
            let result = try JSONDecoder().decode(LeaguesResponse.self, from: jsonData)
            completion(result.result, nil)
        } catch {
            completion(nil, error)
        }
    }
    
    func fetchTeam(forSport sport: String, forId id: Int, completion: @escaping ([Team]?, Error?) -> Void) {
        if sport == "invalid_sport" {
            completion(nil, NSError(domain: "MockNetworkServicesError", code: -1, userInfo: nil))
            return
        }
        guard let jsonData = try? JSONSerialization.data(withJSONObject: teamFakeJsonObj) else {
            completion(nil, NSError(domain: "MockNetworkServicesError", code: -1, userInfo: nil))
            return
        }
        
        do {
            let result = try JSONDecoder().decode(TeamsResponse.self, from: jsonData)
            completion(result.result, nil)
        } catch {
            completion(nil, error)
        }
    }
    
    
    func fetchLeaguesDetails(forSport sport: String, forLeagueDetail detail: Int, from dateFrom: String, to dateTo: String, completion: @escaping ([LeagueDetails]?, Error?) -> Void) {
       // let fakeLeagueDetails: [LeagueDetails] = []
        
        if sport == "invalid_sport" {
            completion(nil, NSError(domain: "MockNetworkServicesError", code: -1, userInfo: nil))
            return
        }
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: LeaguesDetailFakeJsonObj) else {
            completion(nil, NSError(domain: "MockNetworkServicesError", code: -1, userInfo: nil))
            return
        }
        
        do {
            let result = try JSONDecoder().decode(LeagueDetailsResponse.self, from: jsonData)
            completion(result.result, nil)
        } catch {
            completion(nil, error)
        }
    }
}
