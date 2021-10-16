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
    let name, born: String
    let titles: [String]
}
