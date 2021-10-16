//
//  House.swift
//  GoTDemoApp
//
//  Created by Coding on 10/14/21.
//  Copyright © 2021 Vaporstream. All rights reserved.
//

import Foundation

struct House: Codable {
    let url: String
    let name, region, coatOfArms, words: String
    let titles, seats: [String]
    let currentLord, heir, overlord: String
    let founded, founder, diedOut: String
    let ancestralWeapons: [String]
    let cadetBranches: [String]
    let swornMembers: [String]
    
    func houseAttributes() -> [String:String]{
        var results = [String:String]()
        
        results = [
            "Members" : "\(swornMembers.count)",
            "Region" : region,
            "Words" : words
        ]
        
        if founded != "" {
            results["Founded"] = founded
        }
        
        return results
    }

}
