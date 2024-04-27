//
//  TeamDetailsViewController.swift
//  SportsApp
//
//  Created by Mayar on 27/04/2024.
//

import UIKit

class TeamDetailsViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

   
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    
    @IBOutlet weak var teamMembersTable: UITableView!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teamMembersTable.delegate = self
        teamMembersTable.dataSource = self


        // Do any additional setup after loading the view.
    }
    

    /// MARK: - UITableViewDataSource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure your cells here
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamcell", for: indexPath)
        // Configure the cell...
        return cell
    }

}
