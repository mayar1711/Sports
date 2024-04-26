//
//  APIService.swift
//  SportsApp
//
//  Created by Mayar on 25/04/2024.
//

import Foundation
import Alamofire

class APIService {
    static let shared = APIService()
    
    private let baseURL = "https://apiv2.allsportsapi.com"
    private let apiKey = "130041c3994aa5c5e9a427b128c4e48be1235ae9e3b98bccb25f971282dfcff3"
    
    func fetchLeagues(forSport sport: String, completion: @escaping ([League]?, Error?) -> Void) {
        let urlString = "\(baseURL)/\(sport.lowercased())/?met=Leagues&APIkey=\(apiKey)"

        AF.request(urlString).responseDecodable(of: LeaguesResponse.self) { response in
            switch response.result {
            case .success(let leaguesResponse):
                completion(leaguesResponse.result, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    
    func fetchLeaguesDetails(forSport sport: String,forLeagueDetail detail:Int, from dateFrom:String, to dateTo:String, completion: @escaping ([LeagueDetails]?, Error?) -> Void) {
        let urlString = "\(baseURL)/\(sport.lowercased())/?met=Leagues&APIkey=\(apiKey)&from=\(dateFrom)&to=\(dateTo)&leagueId=\(detail)"
        
        AF.request(urlString).responseDecodable(of: LeagueDetailsResponse.self) { response in
                switch response.result {
                case .success(let detailsResponse):
                    completion(detailsResponse.result, nil)
                case .failure(let error):
                    completion(nil, error)
                }      
        }
    }
}
