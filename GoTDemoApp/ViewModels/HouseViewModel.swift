//
//  HouseViewModel.swift
//  GoTDemoApp
//
//  Created by Coding on 10/14/21.
//  Copyright © 2021 Vaporstream. All rights reserved.
//

import Foundation

struct HouseViewModel {
    
    let house: House
    
    var name: String {
        house.name
    }
    
    var currentLord: String? {
        house.currentLord
    }
    
    var numberOfMembers: Int {
        house.swornMembers.count
    }
    
    var words: String {
        house.words
    }
    
    var region: String {
        house.region
    }
    
}
