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

}

