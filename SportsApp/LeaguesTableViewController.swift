//
//  LeaguesTableViewController.swift
//  SportsApp
//
//  Created by Mayar on 23/04/2024.
//

import UIKit
import Alamofire

class LeaguesTableViewController: UITableViewController {

    var selectedSport :String?
    var leagues: [League] = []

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func fetchData(for sport: String) {
        let urlString = "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=130041c3994aa5c5e9a427b128c4e48be1235ae9e3b98bccb25f971282dfcff3"
        
    
        AF.request(urlString).responseJSON { (response: DataResponse<Any, AFError>) in
            switch response.result {
            case .success(let value):
                if let json = value as? [String: Any], let leaguesData = json["result"] as? [[String: Any]] {
                    self.leagues = leaguesData.compactMap { League(json: $0) }
                    self.tableView.reloadData()
                    
                    print(self.leagues)

                }
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leaguesCell", for: indexPath)


        return cell
    }
    


}
