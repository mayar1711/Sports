//
//  League.swift
//  SportsApp
//
//  Created by Mayar on 23/04/2024.
//

import Foundation

class League {
    let name: String
    let country: String
    let logoURL: URL?

    init?(json: [String: Any]) {
        guard let name = json["league_name"] as? String,
              let country = json["country_name"] as? String else {
            return nil
        }

        self.name = name
        self.country = country

        if let logoString = json["league_logo"] as? String {
            self.logoURL = URL(string: logoString)
        } else {
            self.logoURL = nil
        }
    }
}

