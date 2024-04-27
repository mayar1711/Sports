//
//  LeaguesTableViewController.swift
//  SportsApp
//
//  Created by Mayar on 23/04/2024.
//

import UIKit
import Alamofire
import Kingfisher


class LeaguesTableViewController: UITableViewController , LeagueView{
    
    var leages: League?
    var presenter: LeaguePresenter!

    var selectedSport :String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "leaguesCell")
        presenter = LeaguePresenter(view: self)
        presenter.fetchData(forSport: selectedSport)
        self.title = "Leagues"
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    
    func reloadData() {
        tableView.reloadData()
        print("done")
    }
    
    func showError(message: String) {
        print("Error: \(message)")
    }

    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfLeagues()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "leaguesCell", for: indexPath)
        let league = presenter.league(at: indexPath.row)
        cell.textLabel?.text = league.leagueName
        let imageSize = CGSize(width: 50, height: 50)
        if let imageURL = URL(string: league.leagueLogo ?? "") {
            cell.imageView?.kf.setImage(with: imageURL)
            cell.imageView?.frame.size = imageSize
            cell.imageView?.layer.cornerRadius = imageSize.width / 2
            cell.imageView?.clipsToBounds = true

    }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
            guard let leagueDetailsVC = storyboard.instantiateViewController(withIdentifier: "LeagueDetailsCollectionViewController") as? LeagueDetailsCollectionViewController else {
                return
            }
            
            let league = presenter.league(at: indexPath.row)
            leagueDetailsVC.sportName = selectedSport
            leagueDetailsVC.leagueKey = league.leagueKey
            navigationController?.pushViewController(leagueDetailsVC, animated: true)
        
    }
    


}
