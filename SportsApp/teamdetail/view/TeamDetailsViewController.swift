//
//  TeamDetailsViewController.swift
//  SportsApp
//
//  Created by Shimaa on 27/04/2024.
//

import UIKit
import Kingfisher

class TeamDetailsViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    var sportName:String?
    var sportid:Int?
    
    var player: [Player]?
    var coch: [Coach]?
    var logo: String?
    var teamDetail : Team?
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamMembersTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teamMembersTable.delegate = self
        teamMembersTable.dataSource = self
        
        print(player?.count)
        print(coch?.count)
        
        if let teamDetail = teamDetail {
                teamName.text = teamDetail.team_name
                if let logoURLString = teamDetail.team_logo, let logoURL = URL(string: logoURLString) {
                    teamImage.kf.setImage(with: logoURL)
                }
            }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return player?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure your cells here
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamcell", for: indexPath)
        
        //        if indexPath.section == 0 {
        //            cell.imageView?.image = UIImage(named: "bee")
        //            cell.textLabel?.text = "shimaa"
        //            cell.detailTextLabel?.text = "Goalkeepers"
        //        } else {
        //            cell.imageView?.image = UIImage(named: "bee")
        //            cell.textLabel?.text = "shimaa"
        //            cell.detailTextLabel?.text = "Goalkeepers"
        //                }
        
        if indexPath.section == 0 {
                if let coach = coch?[indexPath.row] {
                    cell.textLabel?.text = coach.coach_name
                }
            } else {
                if let player = player?[indexPath.row] {
                    cell.textLabel?.text = player.player_name
                    cell.detailTextLabel?.text = player.player_type
                                
                    if let imageURLString = player.player_image, let imageURL = URL(string: imageURLString) {
                        cell.imageView?.kf.setImage(with: imageURL, placeholder: UIImage(named: "defaultPlayerImage"))}
//                    } else {
//                        cell.imageView?.image = UIImage(named: "defaultPlayerImage")
//                    }
                }
            }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Coaches"
        } else {
            return "Players"
        }
    }
    
    
}
