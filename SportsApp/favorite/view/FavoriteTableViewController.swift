//
//  FavoriteTableViewController.swift
//  SportsApp
//
//  Created by Mayar on 23/04/2024.
//

import UIKit
import Kingfisher
import SDWebImage


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
            
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath)
//
//            if let league = presenter.league(at: indexPath.row) {
//                cell.textLabel?.text = league["league_name"] as? String ?? ""
//                cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
//                
//                let imageSize = CGSize(width: 100, height: 100)
//                cell.imageView?.frame.size = imageSize
//
//                if let imageURLString = league["league_logo"] as? String, let imageURL = URL(string: imageURLString) {
//                    cell.imageView?.kf.setImage(with: imageURL, placeholder: UIImage(named: "bee"), options: [
//                        .processor(DownsamplingImageProcessor(size: imageSize)),
//                        .cacheOriginalImage
//                    ])
//                } else {
//                    cell.imageView?.image = UIImage(named: "bee")
//                }
//            }
//            return cell
//        }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath)

        if let league = presenter.league(at: indexPath.row) {
            cell.textLabel?.text = league["league_name"] as? String ?? ""
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
            
            let imageSize = CGSize(width: 100, height: 100)

            if let imageURLString = league["league_logo"] as? String, let imageURL = URL(string: imageURLString) {
                
                cell.imageView?.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "bee")) { (image, error, cacheType, url) in

                    if let error = error {
                        print("Error loading image: \(error)")
                    }
                    
                    if cacheType == .none {
                        print("Image was downloaded from the network")
                    } else {
                        print("Image was retrieved from cache")
                    }
                    
                    
                    if let image = image {
                        cell.imageView?.frame.size = imageSize
                        cell.imageView?.image = image
                    }
                }
            } else {
                cell.imageView?.image = UIImage(named: "bee")
                cell.imageView?.frame.size = imageSize
            }
        }
        return cell
    }




    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        
        let titleLabel = UILabel()
        titleLabel.text = "Favorite Leagues"
        titleLabel.font = UIFont(name: "Bodoni 72 Smallcaps", size: 40.0)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        return headerView
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.deleteLeague(at: indexPath.row)
            showLeagueRemovedSuccess()
            tableView.reloadData()
            }
    }
    
    
    func showLeagueRemovedSuccess() {
        let alert = UIAlertController(title: "Removed from Favorites", message: "", preferredStyle: .alert)
        
        let titleFont = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor.red]
        let titleAttrString = NSMutableAttributedString(string: "Removed from Favorites", attributes: titleFont)
        alert.setValue(titleAttrString, forKey: "attributedTitle")
        
        present(alert, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            alert.dismiss(animated: true, completion: nil)
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
                leagueDetailsVC.leagueKey = league["league_key"] as? Int
                leagueDetailsVC.leagueName = league["league_name"] as? String
                navigationController?.pushViewController(leagueDetailsVC, animated: true)
            }
        }
    }

}
