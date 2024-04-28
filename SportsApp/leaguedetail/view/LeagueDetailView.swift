//
//  LeagueDetailView.swift
//  SportsApp
//
//  Created by Shimaa on 26/04/2024.
//

import Foundation

protocol LeagueDetailView : AnyObject
{
    func reloadData()
    func showError(message: String)

}
