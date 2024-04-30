//
//  LeaguePresenter.swift
//  SportsApp
//
//  Created by Mayar on 25/04/2024.
//

import Foundation

class LeaguePresenter{
    private weak var view: LeagueView?
    private var leagues: [League] = []
    
    init(view: LeagueView) {
        self.view = view
    }
    
    func fetchData(forSport sportName: String?) {
        guard let sportName = sportName else {
            return
        }
        APIService.shared.fetchLeagues(forSport: sportName) { [weak self] (leagues, error) in
            guard let self = self else { return }
            if let error = error {
                DispatchQueue.main.async {
                    self.view?.showError(message: error.localizedDescription)
                }
            } else if let leagues = leagues {
                self.leagues = leagues
                DispatchQueue.main.async {
                    self.view?.reloadData(list: leagues)
                }
            }
        }
    }
}
