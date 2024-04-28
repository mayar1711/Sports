//
//  FavoriteTableViewController.swift
//  SportsApp
//
//  Created by Mayar on 23/04/2024.
//

import UIKit

class FavoriteTableViewController: UITableViewController , FavoriteViewProtocol {
    
    
    func reloadData() {
        tableView.reloadData()
    }
    
    
    var favoriteLeagues: [[String: Any]] = []
    var presenter: FavoritePresenterProtocol!

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FavoritePresenter(model: FavoriteCoreData.shared)
        presenter.viewDidLoad()
        
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return presenter.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath)
        
        if let league = presenter.league(at: indexPath.row) {
            cell.textLabel?.text = league["league_name"] as? String ?? ""
            if let imageName = league["league_logo"] as? String {
                cell.imageView?.image = UIImage(named: imageName)
            }
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
            presenter.deleteLeague(at: indexPath.row)
            tableView.reloadData()
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
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let leagueDetailsVC = storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsCollectionViewController") as? LeagueDetailsCollectionViewController {
            if let league = presenter.league(at: indexPath.row) {
                leagueDetailsVC.sportName = league["sportName"] as? String
                leagueDetailsVC.leagueKey = league["leagueKey"] as? Int
                navigationController?.pushViewController(leagueDetailsVC, animated: true)
            }
        }
    }

}
