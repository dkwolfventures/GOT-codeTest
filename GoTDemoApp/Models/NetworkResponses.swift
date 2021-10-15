//
//  NetworkResponses.swift
//  GoTDemoApp
//
//  Created by Coding on 10/14/21.
//  Copyright © 2021 Vaporstream. All rights reserved.
//

import Foundation

struct NetworkHouseResponse: Codable {
    let houses: [House]
}

struct NetworkCharacterResponse: Codable {
    let result: Character
}
