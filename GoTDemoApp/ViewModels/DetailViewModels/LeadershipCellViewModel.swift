//
//  LeadershipCellViewModel.swift
//  GoTDemoApp
//
//  Created by Coding on 10/15/21.
//  Copyright © 2021 Vaporstream. All rights reserved.
//

import Foundation

struct LeadershipCellViewModel {
    let character: Character
    
    var name: String {
        character.name
    }
    
    var born: String {
        character.born
    }
    
    var titleOrTitles: String {
        return character.titles.count > 1 ? "Titles" : "Title"
    }
    
    var titles: [String] {
        character.titles
    }
    
}
