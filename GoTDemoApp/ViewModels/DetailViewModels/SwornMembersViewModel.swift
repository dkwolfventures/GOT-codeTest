//
//  SwornMembersViewModel.swift
//  GoTDemoApp
//
//  Created by Coding on 10/16/21.
//  Copyright © 2021 Vaporstream. All rights reserved.
//

import Foundation

struct SwornMembersViewModel{
    
    let char: Character
    
    var name: String {
        return char.name
    }
}
