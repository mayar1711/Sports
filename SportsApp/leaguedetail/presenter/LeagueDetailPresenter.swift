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
    private var team: [Team] = []
        
    init(view: LeagueDetailView) {
      self.view = view
     }
        
    func fetchLastLeaguesData(forSport sportName: String?, leagueKey: Int?) {
        guard let sportName = sportName, let leagueKey = leagueKey else {
            return
        }
        
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.day = -14
        let twoWeeksBeforeToday = calendar.date(byAdding: dateComponents, to: Date()) ?? Date()
        let endDate = calendar.date(byAdding: .day, value: -1, to: Date()) ?? Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let fromDate = dateFormatter.string(from: twoWeeksBeforeToday)
        let toDate = dateFormatter.string(from: endDate)
        
        APIService.shared.fetchLeaguesDetails(forSport: sportName, forLeagueDetail: leagueKey, from: fromDate, to: toDate) { [weak self] (details, error) in
            if let error = error {
                print("Error fetching league details: \(error.localizedDescription)")
            } else if let details = details {
                self?.leagueDetails = details
                
        DispatchQueue.main.async {
                    self?.view?.reloadData()
                }
            }
        }
    }
    
    func fetchUpcomingLeagueData(forSport sportName: String?, leagueKey: Int?) {
        guard let sportName = sportName, let leagueKey = leagueKey else {
            return
        }
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.day = 14
        let twoWeeksAfterToday = calendar.date(byAdding: dateComponents, to: Date()) ?? Date()
        let endDate = calendar.date(byAdding: .day, value: 14, to: Date()) ?? Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let fromDate = dateFormatter.string(from: twoWeeksAfterToday)
        let toDate = dateFormatter.string(from: endDate)
        
        APIService.shared.fetchLeaguesDetails(forSport: sportName, forLeagueDetail: leagueKey, from: fromDate, to: toDate) { [weak self] (details, error) in
            if let error = error {
                print("Error fetching league details: \(error.localizedDescription)")
            } else if let details = details {
                self?.leagueDetails = details
                
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
    
    func fetchData(forSport sportName: String? , forId id: Int?) {
      
        guard let sportName = sportName else {
            return
        }
                
        APIService.shared.fetchTeam(forSport: sportName, forId: id ?? 207)
            { [weak self] (team, error) in
                guard let self = self else { return }
                if let error = error {
                    DispatchQueue.main.async {
                        self.view?.showError(message: error.localizedDescription)
                    }
                } else if let team = team {
                    self.team = team
                    DispatchQueue.main.async {
                        self.view?.reloadData()
                        print(team[1].team_name)
                    }
                }
            }
        }
    func numberOfTeams() -> Int {
        print(team.count)
        return team.count
    }

    func team(at index: Int) -> Team {
        return team[index]
    }
}

