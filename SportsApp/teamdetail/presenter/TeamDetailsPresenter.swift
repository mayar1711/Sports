//
//  TeamDetailsPresenter.swift
//  SportsApp
//
//  Created by Mayar on 27/04/2024.
//

import Foundation


protocol TeamDetailsProvider: AnyObject {
    func fetchData(forSport sportName: String?, forId id: Int?)
    func numberOfTeams() -> Int
    func team(at index: Int) -> Team
}

class TeamDetailsPresenter: TeamDetailsProvider {
    
    private var view: TeamDetailsView?
    private var team: [Team] = []
    
    init(view: TeamDetailsView? = nil) {
        self.view = view
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
