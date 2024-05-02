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
        
        layer.shadowColor = UIColor.black.cgColor
                layer.shadowOpacity = 0.2
                layer.shadowOffset = CGSize(width: 0, height: 2)
                layer.shadowRadius = 3
                layer.masksToBounds = false
                
                sportsImage.contentMode = .scaleAspectFill
                sportsImage.clipsToBounds = true
                sportsImage.layer.cornerRadius = 20
                sportsImage.layer.borderWidth = 5
                sportsImage.layer.borderColor = UIColor.lightGray.cgColor
                
                sportsName.font = UIFont(name: "Bodoni 72 Smallcaps", size: 18)
                sportsName.textAlignment = .center
        }
}
