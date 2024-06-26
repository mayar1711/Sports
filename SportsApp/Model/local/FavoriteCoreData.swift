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
    
    func saveToCoreData(_ dataArray: [[String: Any]], completion: @escaping (Bool, Error?) -> Void) {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                completion(false, NSError(domain: "AppDelegateNotFound", code: -1, userInfo: nil))
                return
            }
            
            let managedContext = appDelegate.persistentContainer.viewContext
            
            for leaguesData in dataArray {
                guard let leagueName = leaguesData["league_name"] as? String,
                      let leagueLogo = leaguesData["league_logo"] as? String,
                      let leagueKey = leaguesData["league_key"] as? Int,
                      let sportName = leaguesData["sportName"] as? String
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
                        fav.sportName = sportName
                        
                        try managedContext.save()
                        print("League \(leagueName) saved to Core Data.")
                    } else {
                        print("League \(leagueName) already exists in Core Data. Skipping save.")
                    }
                } catch {
                    completion(false, error)
                    continue
                }
            }
            
            completion(true, nil)
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
                    "league_logo": favorite.leagueLogo ?? "" ,
                    "sportName" : favorite.sportName ?? ""
                ]
            }
            
        } catch {
            print("Error fetching data from Core Data: \(error.localizedDescription)")
        }
    }
    
    func deleteFromCoreData(leagueName: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<FavoriteLeagues> = FavoriteLeagues.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "leagueName == %@", leagueName)
        
        do {
            let existingLeagues = try managedContext.fetch(fetchRequest)
            for league in existingLeagues {
                managedContext.delete(league)
            }
            try managedContext.save()
            print("League \(leagueName) deleted from Core Data.")
        } catch {
            print("Error deleting league from Core Data: \(error.localizedDescription)")
        }
    }
    
    func isLeagueInFavorites(leagueKey: Int, leagueName: String) -> Bool {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return false
            }
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let fetchRequest: NSFetchRequest<FavoriteLeagues> = FavoriteLeagues.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "leagueName == %@ AND leagueKey == %@", leagueName, NSNumber(value: leagueKey))
            
            do {
                let existingLeagues = try managedContext.fetch(fetchRequest)
                return !existingLeagues.isEmpty
            } catch {
                print("Error checking league in favorites: \(error.localizedDescription)")
                return false
            }
        }

    
}
