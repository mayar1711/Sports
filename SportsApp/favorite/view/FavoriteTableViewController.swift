//
//  FavoriteTableViewController.swift
//  SportsApp
//
//  Created by Mayar on 23/04/2024.
//

import UIKit

class FavoriteTableViewController: UITableViewController {
    
    var favoriteLeagues: [[String: Any]] = []
    
    override func viewWillAppear(_ animated: Bool) {
        fetchDataAndReloadTable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

            if let imageURLString = league["league_logo"] as? String, let imageURL = URL(string: imageURLString) {
                cell.imageView?.kf.setImage(with: imageURL)
            } else {
                cell.imageView?.image = UIImage(named: "bee")
            }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Favorite Leagues"
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
        
        print("Leagues saved in Core Data:")
        for league in favoriteLeagues {
            if let leagueName = league["league_name"] as? String {
                print("- \(leagueName)")
            }
        }
    }
}
