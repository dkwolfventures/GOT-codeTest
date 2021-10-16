//
//  HouseAttributeViewModel.swift
//  GoTDemoApp
//
//  Created by Coding on 10/15/21.
//  Copyright © 2021 Vaporstream. All rights reserved.
//

import Foundation

struct HouseAttributeViewModel {
    
    let house: House
    
    var attributes: [String:String] {
        return house.houseAttributes()
    }
    
}
