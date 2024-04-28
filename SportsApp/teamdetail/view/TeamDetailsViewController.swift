//
//  TeamDetailsViewController.swift
//  SportsApp
//
//  Created by Shimaa on 27/04/2024.
//

import UIKit

class TeamDetailsViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    var sportName:String?
    var sportid:Int?
    
    var team: [Player]?
    var coch: [Coach]?
    
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamMembersTable: UITableView!
    
   override func viewDidLoad() {
        super.viewDidLoad()
        
        teamMembersTable.delegate = self
        teamMembersTable.dataSource = self
        
       print(team?.count)
       print(coch?.count)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
                    return 1
                } else {
                    return 5
                }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure your cells here
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamcell", for: indexPath)
        
        if indexPath.section == 0 {
            cell.imageView?.image = UIImage(named: "bee")
            cell.textLabel?.text = "shimaa"
            cell.detailTextLabel?.text = "Goalkeepers"
        } else {
            cell.imageView?.image = UIImage(named: "bee")
            cell.textLabel?.text = "shimaa"
            cell.detailTextLabel?.text = "Goalkeepers"
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
