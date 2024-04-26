//
//  LeagueDetailsCollectionViewController.swift
//  SportsApp
//
//  Created by Shimaa on 26/04/2024.
//

import UIKit

private let reuseIdentifier = "LeaguesDetailsCell"

class LeagueDetailsCollectionViewController: UICollectionViewController {
    
    var sportName:String?
    var leagueKey:Int?
    
    var leagueDetails: [LeagueDetails] = [] 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let sportName = sportName {
                print("Sport Name: \(sportName)")
            } else {
                print("Sport Name is nil")
            }
            
            if let leagueKey = leagueKey {
                print("League Key: \(leagueKey)")
            } else {
                print("League Key is nil")
            }
        
    

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        let cellNib = UINib(nibName: "LeagueDetailsCollectionViewCell", bundle: nil)
                collectionView?.register(cellNib, forCellWithReuseIdentifier: "LeaguesDetailsCell")
        
//        let headerNib = UINib(nibName: "SectionHeaderView", bundle: nil)
//            collectionView?.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeaderView")
                
                // Configure compositional layout
                let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
                    if sectionIndex == 0 {
                        // First section: Single item layout
                        return self.createTopSectionLayout()
                    } else {
                        // Second section: Vertical layout with one item per row
                        return self.createSecondSectionLayout()
                    }
                }
                
                collectionView.collectionViewLayout = layout
                
                // Set vertical scrolling
                if let customFlowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
                    customFlowLayout.scrollDirection = .vertical
                }
            }
    
    func reloadData() {
            collectionView.reloadData()
        }
        
        func showError(message: String) {
        
            print("Error: \(message)")
        }

            
            // MARK: - Compositional Layouts
            
            func createTopSectionLayout() -> NSCollectionLayoutSection {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            }
            
            func createSecondSectionLayout() -> NSCollectionLayoutSection {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200)) // Set estimated item height

                    let item = NSCollectionLayoutItem(layoutSize: itemSize)

                    // Adjust group size to control the height of each group (row)
                    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(150)) // Set estimated group height

                    let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)

                    let section = NSCollectionLayoutSection(group: group)
                    section.interGroupSpacing = 10
                
                return section
            }
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if section == 0 {
                    return 1
                } else {
                    return 10
                }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeaguesDetailsCell", for: indexPath) as! LeagueDetailsCollectionViewCell
    
        // Configure the cell
        if indexPath.section == 0 {
                    // Configure first section cell
                    cell.team1Img.image = UIImage(named: "bee")
                    cell.team2Img.image = UIImage(named: "n")
                    cell.team1Name.text = "Team A"
                    cell.team2Name.text = "Team B"
                } else {
                    cell.team1Img.image = UIImage(named: "bee")
                    cell.team2Img.image = UIImage(named: "n")
                    cell.team1Name.text = "Team A"
                    cell.team2Name.text = "Team B"
                }
        return cell
    }
    
//    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if kind == UICollectionView.elementKindSectionHeader {
//            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeaderView", for: indexPath) as! SectionHeaderView
//
//            // Configure header title
//            if indexPath.section == 0 {
//                headerView.titleLabel.text = "First Section"
//            } else {
//                headerView.titleLabel.text = "Second Section"
//            }
//
//            return headerView
//        }
//
//        return UICollectionReusableView()
//    }

}
