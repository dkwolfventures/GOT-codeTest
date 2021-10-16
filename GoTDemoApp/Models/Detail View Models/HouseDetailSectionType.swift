//
//  HouseDetailSectionType.swift
//  GoTDemoApp
//
//  Created by Coding on 10/15/21.
//  Copyright © 2021 Vaporstream. All rights reserved.
//

import Foundation

enum HouseDetailSectionType: CaseIterable {
    case houseInfo
    case leadership
    case swornMembers
    
    var title: String {
        switch self {
        case .houseInfo:
            return "House:"
        case .leadership:
            return "Leadership"
        case .swornMembers:
            return "Sworn Members"
        }
    }
}
