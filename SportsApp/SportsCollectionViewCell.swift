//
//  SportsCollectionViewCell.swift
//  SportsApp
//
//  Created by Mayar on 23/04/2024.
//

import UIKit

class SportsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sportsImage: UIImageView!
    
    
    @IBOutlet weak var sportsName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        sportsImage.contentMode = .scaleAspectFill
        sportsImage.clipsToBounds = true 
    }

    
}
