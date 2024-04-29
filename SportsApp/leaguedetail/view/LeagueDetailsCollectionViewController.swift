//
//  LeagueDetailsCollectionViewController.swift
//  SportsApp
//
//  Created by Shimaa on 26/04/2024.
//

import UIKit
import Kingfisher


private let reuseIdentifier = "LeaguesDetailsCell"
private let headerReuseIdentifier = "SectionHeader"

class LeagueDetailsCollectionViewController: UICollectionViewController,LeagueDetailView ,UICollectionViewDelegateFlowLayout{
    
    var sportName:String?
    
    var leagueKey:Int?
    var leagueName:String?
    var leagueImage:String?
    
    var leagueDetailPresenter: LeagueDetailPresenter!
    var leagueDetails: [LeagueDetails] = []
    private var team: [Team] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let heartImage = UIImage(systemName: "heart")
        
        let favoriteButton = UIBarButtonItem(image: heartImage, style: .plain, target: self, action: #selector(favoriteButtonTapped))
        navigationItem.rightBarButtonItem = favoriteButton

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
                
                let cellNib = UINib(nibName: "LeagueDetailsCollectionViewCell", bundle: nil)
                collectionView?.register(cellNib, forCellWithReuseIdentifier: "LeaguesDetailsCell")
                
                // Register header view
                collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier)
                
                leagueDetailPresenter = LeagueDetailPresenter(view: self)
                leagueDetailPresenter.fetchLastLeaguesData(forSport: sportName, leagueKey: leagueKey)
                leagueDetailPresenter.fetchUpcomingLeagueData(forSport: sportName, leagueKey: leagueKey)
                leagueDetailPresenter.fetchData(forSport: sportName, forId: leagueKey)
                
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
    
    @objc func favoriteButtonTapped() {
        if let favoriteButton = navigationItem.rightBarButtonItem {
           if favoriteButton.tintColor == .red {
               favoriteButton.tintColor = nil
           } else {
               favoriteButton.tintColor = .red
               print("before if.")
                    

             if let leagueKey = leagueKey {
                        if let leagueName = leagueName {
                            if let leagueLogo = leagueImage {
                                print("inside if.")
                                print("leagueKey = \(leagueKey)")
                                print("leagueLogo = \(leagueLogo)")
                                print("leagueName = \(leagueName)")
                                print("sportName = \(sportName ?? "hhh")")
                                print("Inside if.")
                                let leagueData: [String: Any] = [
                                    "league_name": leagueName,
                                    "league_logo": leagueLogo,
                                    "league_key": leagueKey,
                                    "sportName" : sportName!
                                ]
                                
                                FavoriteCoreData.shared.saveToCoreData([leagueData])
                                print("Data is inserted.")
                            } else {
                                print("League logo is nil.")
                            }
                        } else {
                            print("League name is nil.")
                        }
                    } else {
                        print("League key is nil.")
                    }

                  FavoriteCoreData.shared.fetchDataFromCoreData()
                print("Leagues in Core Data after adding:")
            for league in FavoriteCoreData.shared.favoriteLeagues {
                if let leagueName = league["league_name"] as? String {
                print("- \(leagueName)")
                }
            }
                    reloadData()
        }
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
            return leagueDetailPresenter.numberOfTeams()
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeaguesDetailsCell", for: indexPath) as! LeagueDetailsCollectionViewCell
    
        if indexPath.section == 0 {
            let leagueDetail = leagueDetailPresenter.leagueDetail(at: indexPath.item)
            cell.team1Name.text = leagueDetail?.eventHomeTeam ?? "not selected"
            cell.team2Name.text = leagueDetail?.eventAwayTeam ?? "not selected"
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
                
            cell.vsText.text = "VS."
            
        } else if indexPath.section == 1 {
            
            let leagueDetail = leagueDetailPresenter.leagueDetail(at: indexPath.item)
            cell.team1Name.text = leagueDetail?.eventHomeTeam ?? "not selected"
            cell.team2Name.text = leagueDetail?.eventAwayTeam ?? "not selected"
            cell.dayText.text = leagueDetail?.eventDay ?? "not selected"
            cell.timeText.text = leagueDetail?.eventTime ?? "not selected"
            cell.vsText.text = leagueDetail?.eventHalftimeResult ?? ""
            
            
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
            let leagueDetail = leagueDetailPresenter.team(at: indexPath.item)
            let imageSize = CGSize(width: 80, height: 50)
            if let awayTeamLogoURL = URL(string: leagueDetail.team_logo ?? "bee") {
              cell.team1Img.kf.setImage(with: awayTeamLogoURL)
            }
            cell.team1Name.text = ""
            cell.vsText.text = ""
            cell.dayText.text =  ""
            cell.timeText.text =  ""
        }
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.bounds.width, height: 50) // Adjust the height as needed
        }
        
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseIdentifier, for: indexPath)
            
            headerView.subviews.forEach { $0.removeFromSuperview() }
            
         
            let titleLabel = UILabel()
            titleLabel.text = "Section \(indexPath.section + 1) Header" 
            titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
            titleLabel.textColor = UIColor.black
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            headerView.addSubview(titleLabel)
            
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
                titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
            ])
            
            return headerView
        } else {
            fatalError("Unexpected supplementary view kind: \(kind)")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let leagueDetail = leagueDetailPresenter.team(at: indexPath.item)
        let id = leagueDetail.team_key
        if indexPath.section == 2 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let teamsVC = storyboard.instantiateViewController(withIdentifier: "TeamDetailsViewController") as? TeamDetailsViewController {
                teamsVC.sportName = sportName
                teamsVC.player = leagueDetail.players
                teamsVC.coch = leagueDetail.coaches
                teamsVC.sportid = id
                teamsVC.logo = leagueDetail.team_logo
                teamsVC.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(teamsVC, animated: true)
            }
        }
    }
}
