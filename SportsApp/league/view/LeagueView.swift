//
//  LeagueView.swift
//  SportsApp
//
//  Created by Mayar on 25/04/2024.
//

import Foundation

protocol LeagueView : AnyObject
{
    
    func reloadData(list : [League])
    func showError(message: String)

}
