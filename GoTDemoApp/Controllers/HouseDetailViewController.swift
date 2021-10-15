//
//  HouseDetailViewController.swift
//  GoTDemoApp
//
//  Created by Coding on 10/14/21.
//  Copyright © 2021 Vaporstream. All rights reserved.
//

import Foundation
import UIKit

class HouseDetailViewController: UIViewController {
    
    //MARK: - properties
    
    private var house: House
    
    //MARK: - lifecycle
    
    init(_ house: House){
        self.house = house
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
    }
    
    //MARK: - actions
    
    //MARK: - helpers
}
