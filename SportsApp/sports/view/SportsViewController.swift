//
//  SportsViewController.swift
//  SportsApp
//
//  Created by Mayar on 23/04/2024.
//

import UIKit

class SportsViewController: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {

    let sportsNames = ["Football", "Basketball", "Tennis", "Cricket"]
    let sportsImages = ["football","basketball","tennis-2","baseball"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        sportCollection.dataSource = self
        sportCollection.delegate = self

      //  self.title = "Sports"

    }
    

    @IBOutlet weak var sportCollection: UICollectionView!
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sportsCell", for: indexPath) as! SportsCollectionViewCell

        cell.sportsName.text = sportsNames[indexPath.item]
        cell.sportsImage.image = UIImage(named: sportsImages[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 150, height: 280)
        }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedSportName = sportsNames[indexPath.item]
        let leaguesViewController = LeaguesTableViewController()
        leaguesViewController.selectedSport = selectedSportName
        leaguesViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(leaguesViewController, animated: true)
    }

}
