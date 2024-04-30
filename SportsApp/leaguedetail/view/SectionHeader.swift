//
//  SectionHeader.swift
//  SportsApp
//
//  Created by Shimaa on 30/04/2024.
//

import Foundation
import UIKit


class SectionHeader: UICollectionReusableView {
    let titleLabel: UILabel = {
            let label = UILabel()
            return label
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            addSubview(titleLabel)
            
            
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
