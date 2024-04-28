//
//  FavoritePresenterProtocol.swift
//  SportsApp
//
//  Created by Mayar on 28/04/2024.
//

import Foundation

protocol FavoritePresenterProtocol {
    func viewDidLoad()
    func numberOfRows() -> Int
    func league(at index: Int) -> [String: Any]?
    func deleteLeague(at index: Int)
}

protocol FavoritePresenterDelegate: AnyObject {
    func didDeleteRow(at index: Int)
}


class FavoritePresenter: FavoritePresenterProtocol {
    weak var view: FavoriteViewProtocol?
    private let model: FavoriteCoreData
    
    init(model: FavoriteCoreData) {
        self.model = model
    }
    
    func viewDidLoad() {
        model.fetchDataFromCoreData()
        view?.reloadData()
    }
    
    func numberOfRows() -> Int {
        return model.favoriteLeagues.count
    }
    
    func league(at index: Int) -> [String: Any]? {
        guard index >= 0 && index < model.favoriteLeagues.count else {
            return nil
        }
        return model.favoriteLeagues[index]
    }
    
    func deleteLeague(at index: Int) {
        guard let league = league(at: index), let leagueName = league["league_name"] as? String else {
            return
        }
        model.deleteFromCoreData(leagueName: leagueName)
        model.fetchDataFromCoreData()
        view?.reloadData()
    }
}
