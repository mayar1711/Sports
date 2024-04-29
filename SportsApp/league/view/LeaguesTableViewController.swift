//
//  LeaguesTableViewController.swift
//  SportsApp
//
//  Created by Mayar on 23/04/2024.
//

import UIKit
import Alamofire
import Kingfisher
import Reachability

class LeaguesTableViewController: UITableViewController , LeagueView{
    
    var leages: League?
    var presenter: LeaguePresenter!
    var activityIndicator = UIActivityIndicatorView(style: .large)
    var selectedSport :String?
    let reachability = try! Reachability()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "leaguesCell")
        presenter = LeaguePresenter(view: self)
        presenter.fetchData(forSport: selectedSport)
        self.title = "Leagues"
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        setupActivityIndicator()
        startMonitoringReachability()
        activityIndicator.startAnimating()
    }
    
    func startMonitoringReachability() {
        reachability.whenReachable = { _ in
            self.presenter.fetchData(forSport: self.selectedSport)
        }
        reachability.whenUnreachable = { _ in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "No Internet Connection", message: "Please check your network settings and try again.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                    self.navigationController?.popViewController(animated: true)
                }
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start reachability notifier")
        }
    }
    
    func stopMonitoringReachability() {
        reachability.stopNotifier()
    }

    func setupActivityIndicator() {
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     //   activityIndicator.startAnimating()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        activityIndicator.stopAnimating()
    }

    func reloadData() {
        tableView.reloadData()
        print("done")
        activityIndicator.stopAnimating()
    }
    
    func showError(message: String) {
        print("Error: \(message)")
        activityIndicator.stopAnimating()

        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }


    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        activityIndicator.stopAnimating()
    }


    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfLeagues()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leaguesCell", for: indexPath)
        let league = presenter.league(at: indexPath.row)
        cell.textLabel?.text = league.leagueName
        
        let imageSize = CGSize(width: 60, height: 60)
        cell.imageView?.frame = CGRect(origin: .zero, size: imageSize)
        
        if let imageURL = URL(string: league.leagueLogo ?? "") {
            let processor = DownsamplingImageProcessor(size: imageSize)
            cell.imageView?.kf.indicatorType = .activity
            cell.imageView?.kf.setImage(
                with: imageURL,
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ],
                completionHandler: { result in
                    switch result {
                    case .success(let value):
                        cell.imageView?.layer.cornerRadius = 25
                        cell.imageView?.layer.masksToBounds = true
                        cell.imageView?.image = value.image
                    case .failure(let error):
                        print("Error loading image: \(error)")
                    }
                }
            )
        }
        
        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let leagueDetailsVC = storyboard.instantiateViewController(withIdentifier: "LeagueDetailsCollectionViewController") as? LeagueDetailsCollectionViewController else {
            return
        }
        
        let league = presenter.league(at: indexPath.row)
        leagueDetailsVC.sportName = selectedSport
        leagueDetailsVC.leagueKey = league.leagueKey
        leagueDetailsVC.leagueName = league.leagueName
        leagueDetailsVC.leagueImage = league.leagueLogo
        leagueDetailsVC.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(leagueDetailsVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    deinit {
        stopMonitoringReachability()
    }
}
