//
//  FavoriteCoreData.swift
//  SportsApp
//
//  Created by Shimaa on 24/04/2024.
//

import Foundation
import CoreData
import UIKit

class FavoriteCoreData{
    var favoriteLeagues: [[String: Any]] = []
    
   static let shared = FavoriteCoreData()
    
    private init() {}
    
    func saveToCoreData(_ dataArray: [[String: Any]]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        for leaguesData in dataArray {
            guard let leagueName = leaguesData["league_name"] as? String,
                  let leagueLogo = leaguesData["league_logo"] as? String,
                  let leagueKey = leaguesData["league_key"] as? Int
                  //let salary = employeeData["employee_salary"] as? String
            else {
                continue
            }
            
            let fetchRequest: NSFetchRequest<FavoriteLeagues> = FavoriteLeagues.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "leagueName == %@", leagueName)
            
            do {
                let existingLeagues = try managedContext.fetch(fetchRequest)
                
                if existingLeagues.isEmpty {
                    let fav = FavoriteLeagues(context: managedContext)
                    fav.leagueKey = NSDecimalNumber(value: leagueKey)
                    fav.leagueLogo = leagueLogo
                    fav.leagueName = leagueName
                   // fav.sportName =
                    
                    try managedContext.save()
                    print("League \(leagueName) saved to Core Data.")
                } else {
                    print("League \(leagueName) already exists in Core Data. Skipping save.")
                }
            } catch {
                print("Error fetching data from Core Data: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchDataFromCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<FavoriteLeagues> = FavoriteLeagues.fetchRequest()
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            favoriteLeagues = results.map { favorite in
                [
                    "league_name": favorite.leagueName ?? "",
                    "league_key": favorite.leagueKey as? Int ?? 0,
                    "league_logo": favorite.leagueLogo ?? ""
                ]
            }
            //tableView.reloadData()
        } catch {
            print("Error fetching data from Core Data: \(error.localizedDescription)")
        }
    }
}
