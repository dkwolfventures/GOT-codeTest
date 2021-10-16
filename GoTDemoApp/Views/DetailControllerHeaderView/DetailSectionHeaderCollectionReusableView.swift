//
//  DetailSectionHeaderCollectionReusableView.swift
//  GoTDemoApp
//
//  Created by Coding on 10/16/21.
//  Copyright © 2021 Vaporstream. All rights reserved.
//

import UIKit

class DetailSectionHeaderCollectionReusableView: UICollectionReusableView {
        
    //MARK: - properties
    
    static let identifier = "DetailSectionHeaderCollectionReusableView"
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .label
        label.text = "Hello"
        return label
    }()
    
    //MARK: - lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        headerLabel.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: self.width/20)
    }
    
    //MARK: - helpers
    
    public func configure(with index: Int){
        
        switch index {
        case 0:
            headerLabel.text = "Houose Facts"
            
        case 1:
            headerLabel.text = "Leadership"
            
        case 2:
            headerLabel.text = "Sworn Members"
            
        default:
            fatalError()
        }
        
    }
    
}
