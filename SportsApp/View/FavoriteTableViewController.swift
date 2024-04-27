//
//  FavoriteTableViewController.swift
//  SportsApp
//
//  Created by Mayar on 23/04/2024.
//

import UIKit

class FavoriteTableViewController: UITableViewController {
    
    var favoriteLeagues: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dummyDataArray: [[String: Any]] = [
            
            ["league_name": "Premier League", "league_logo": "n", "league_key": 1],
            ["league_name": "La Liga", "league_logo": "bee", "league_key": 2],
            ["league_name": "Bundesliga", "league_logo": "bundesliga", "league_key": 3]
        ]
        
        FavoriteCoreData.shared.saveToCoreData(dummyDataArray)

        fetchDataAndReloadTable()
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  favoriteLeagues.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath)
        
        let league = favoriteLeagues[indexPath.row]
        cell.textLabel?.text = league["league_name"] as? String ?? ""
        if let imageName = league["league_logo"] as? String {
            cell.imageView?.image = UIImage(named: imageName)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "test table"
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 114
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let league = favoriteLeagues[indexPath.row]
            if let leagueName = league["league_name"] as? String {
                FavoriteCoreData.shared.deleteFromCoreData(leagueName: leagueName)
                fetchDataAndReloadTable()
            }
        }
    }
    

    
    func fetchDataAndReloadTable() {
        FavoriteCoreData.shared.fetchDataFromCoreData()
        favoriteLeagues = FavoriteCoreData.shared.favoriteLeagues
        tableView.reloadData()
    }
}
