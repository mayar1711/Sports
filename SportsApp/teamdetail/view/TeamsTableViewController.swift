//
//  TeamsTableViewController.swift
//  SportsApp
//
//  Created by Mayar on 27/04/2024.
//

import UIKit

class TeamsTableViewController: UITableViewController , TeamDetailsView {
    
    var presenter: TeamDetailsPresenter!
        var sportName: String?
        var id: Int?
        var teams: [Team]?
        var player: [Player]?
        var coch: [Coach]?
    
    func reloadData() {
        print("done")
    }
    
    func showError(message: String) {
        print("error \(message)")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = TeamDetailsPresenter(view: self)
        presenter.fetchData(forSport: sportName, forId: id)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 1
        } else {
            return player?.count ?? 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamCell", for: indexPath)

        // Configure the cell...
        if indexPath.section == 0 {
            if let coach = coch?[indexPath.row] {
                cell.textLabel?.text = coach.coach_name
                cell.imageView?.image = nil
                
            }
        } else {
            if let player = player?[indexPath.row] {
                cell.textLabel?.text = player.player_name
                cell.detailTextLabel?.text = player.player_type
                if let imageURLString = player.player_image, let imageURL = URL(string: imageURLString) {
                    cell.imageView?.kf.setImage(with: imageURL, placeholder: UIImage(named: "defaultPlayerImage"))
                } else {
                    cell.imageView?.image = UIImage(named: "defaultPlayerImage")
                }
            }
        }
        return cell
    }

  
    

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "Bodoni 72 Smallcaps", size: 25.0)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        switch section {
        case 0:
            titleLabel.text = "Coche"
        case 1:
            titleLabel.text = "Players"
        default:
            titleLabel.text = "Section \(section)"
        }
        
        return headerView
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

}
