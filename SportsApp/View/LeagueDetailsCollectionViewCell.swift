//
//  LeagueDetailsCollectionViewCell.swift
//  SportsApp
//
//  Created by Shimaa on 26/04/2024.
//

import UIKit

class LeagueDetailsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backgroundview: UIView!
    @IBOutlet weak var team1Img: UIImageView!
    @IBOutlet weak var team2Img: UIImageView!
    @IBOutlet weak var team1Name: UILabel!
    @IBOutlet weak var team2Name: UILabel!
    
    @IBOutlet weak var vsText: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Configure appearance of the background view
        backgroundview!.layer.cornerRadius = 10
        backgroundview!.clipsToBounds = true
        backgroundview!.backgroundColor = UIColor.systemGray3
        
        backgroundview.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        backgroundview.frame = self.bounds
    }


}
