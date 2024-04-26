//
//  LeagueDetailPresenter.swift
//  SportsApp
//
//  Created by Shimaa on 26/04/2024.
//

import Foundation
class LeagueDetailPresenter{
    private weak var view: LeagueDetailView?
    private var leagueDetails: [LeagueDetails] = []
        
    init(view: LeagueDetailView) {
      self.view = view
     }
        
    func fetchData(forSport sportName: String?, leagueKey: Int?) {
        guard let sportName = sportName, let leagueKey = leagueKey else {
            return
        }
            
    APIService.shared.fetchLeaguesDetails(forSport: sportName, forLeagueDetail: leagueKey, from: "2024-04-23", to: "2024-04-26") { [weak self] (details, error) in
                if let error = error {
                    print("Error fetching league details: \(error.localizedDescription)")
                } else if let details = details {
                    self?.leagueDetails = details
                    
                    print("League Details:")
                    for detail in details {
                        var detailsString = "Event Details: "
                        if let eventDay = detail.eventDay {
                            detailsString += "Date: \(eventDay)"
                        }
                        if let eventTime = detail.eventTime {
                            detailsString += ", Time: \(eventTime)"
                        }
                        if let eventHomeTeam = detail.eventHomeTeam {
                            detailsString += ", Home Team: \(eventHomeTeam)"
                        }
                        if let eventAwayTeam = detail.eventAwayTeam {
                            detailsString += ", Away Team: \(eventAwayTeam)"
                        }
                        if let homeTeamLogo = detail.homeTeamLogo {
                            detailsString += ", Home Team Logo URL: \(homeTeamLogo)"
                        }
                        if let awayTeamLogo = detail.awayTeamLogo {
                            detailsString += ", Away Team Logo URL: \(awayTeamLogo)"
                        }
                        print(detailsString)
                    }

                    
                DispatchQueue.main.async {
                    self?.view?.reloadData()
                    }
                }
            }
        }
        
    func numberOfLeagueDetails() -> Int {
            return leagueDetails.count
    }
        
    func leagueDetail(at index: Int) -> LeagueDetails? {
            guard index >= 0 && index < leagueDetails.count else {
                return nil
            }
            return leagueDetails[index]
    }

}

