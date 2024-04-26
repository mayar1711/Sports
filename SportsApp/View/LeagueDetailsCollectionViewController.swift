//
//  LeagueDetailsCollectionViewController.swift
//  SportsApp
//
//  Created by Shimaa on 26/04/2024.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "LeaguesDetailsCell"

class LeagueDetailsCollectionViewController: UICollectionViewController,LeagueDetailView {
    
    var sportName:String?
    var leagueKey:Int?
    
    var leagueDetailPresenter: LeagueDetailPresenter!
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
        
        leagueDetailPresenter = LeagueDetailPresenter(view: self)
        leagueDetailPresenter.fetchData(forSport: sportName, leagueKey: leagueKey)
        

        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            switch sectionIndex {
                case 0:
                    return self.createTopSectionLayout()
                case 1:
                    return self.createSecondSectionLayout()
                case 2:
                    return self.createThirdSectionLayout()
                default:
                    return nil
            }
        }
        layout.configuration.interSectionSpacing = 30
        collectionView.collectionViewLayout = layout
                
        if let customFlowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            customFlowLayout.scrollDirection = .vertical
            }
    }
    
    func reloadData() {
        collectionView.reloadData()
        print("Data fetched.")
    }
        
    func showError(message: String) {
        print("Error: \(message)")
    }

            
    // MARK: - Compositional Layouts
            
    func createTopSectionLayout() -> NSCollectionLayoutSection {
    
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.98)
          , heightDimension: .fractionalHeight(1))
          let item = NSCollectionLayoutItem(layoutSize: itemSize)
          
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0)
          , heightDimension: .absolute(150))
          let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize
          , subitems: [item])
              group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
              , bottom: 0, trailing: 15)
              
          let section = NSCollectionLayoutSection(group: group)
              section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 12
              , bottom: 50, trailing: 0)
              section.orthogonalScrollingBehavior = .continuous
              
             return section
    }
    
    

    func createSecondSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(120))

        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 20, trailing: 10)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10

        return section
    }
    
    func createThirdSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.2))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 8
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 12, bottom: 10, trailing: 12)
            
            // for horizontal scrolling
            section.orthogonalScrollingBehavior = .continuous
            
            return section
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if section == 0 {
                return 1
        } 
        else if section == 1 {
            return leagueDetailPresenter.numberOfLeagueDetails()
        }
        else {
                return 5
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeaguesDetailsCell", for: indexPath) as! LeagueDetailsCollectionViewCell
    
        if indexPath.section == 0 {
            cell.team1Img.image = UIImage(named: "bee")
            cell.team2Img.image = UIImage(named: "n")
            cell.team1Name.text = "Team A"
            cell.team2Name.text = "Team B"
            cell.vsText.text = "VS."
        } else if indexPath.section == 1 {
            
            let leagueDetail = leagueDetailPresenter.leagueDetail(at: indexPath.item)
            cell.team1Name.text = leagueDetail?.eventHomeTeam ?? "not selected"
            cell.team2Name.text = leagueDetail?.eventAwayTeam ?? "not selected"
            cell.vsText.text = "VS."
            
            let imageSize = CGSize(width: 50, height: 50)
            if let awayTeamLogoURL = URL(string: leagueDetail?.awayTeamLogo ?? "bee") {
              cell.team2Img.kf.setImage(with: awayTeamLogoURL)
            }
            if let homeTeamLogoURL = URL(string: leagueDetail?.homeTeamLogo ?? "bee") {
                cell.team1Img.kf.setImage(with: homeTeamLogoURL)
            }
            
            if let homeTeamLogoURL = leagueDetail?.homeTeamLogo, let url = URL(string: homeTeamLogoURL) {
                cell.team1Img.kf.setImage(with: url)
            }
            
            if let awayTeamLogoURL = leagueDetail?.awayTeamLogo, let url = URL(string: awayTeamLogoURL) {
                cell.team2Img.kf.setImage(with: url)
            }
        } else {
            cell.team1Img.image = UIImage(named: "bee")
            cell.team1Name.text = "Team c"
            cell.vsText.text = ""
        }
        return cell
    }
}
