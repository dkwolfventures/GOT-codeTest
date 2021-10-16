//
//  Character.swift
//  GoTDemoApp
//
//  Created by Coding on 10/14/21.
//  Copyright © 2021 Vaporstream. All rights reserved.
//

import Foundation

struct Character: Codable, Equatable {
    let url: String
    let name, gender, culture, born: String
    let died: String
    let titles, aliases: [String]
    let father, mother, spouse: String
    let allegiances, books: [String]
    let povBooks, tvSeries, playedBy: [String]
}
