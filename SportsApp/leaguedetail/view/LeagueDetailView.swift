//
//  LeagueDetailView.swift
//  SportsApp
//
//  Created by Shimaa on 26/04/2024.
//

import Foundation

protocol LeagueDetailView : AnyObject
{
    func reloadTeamData(list : [Team])
    func reloadUpcomingLeagueData(list : [LeagueDetails])
    func reloadLastLeaguesData(list : [LeagueDetails])
    func showFavoriteLeagueSavedSuccess()
    func showError(message: String)

}
