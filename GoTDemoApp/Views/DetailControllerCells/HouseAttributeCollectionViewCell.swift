//
//  HouseAttributeCollectionViewCell.swift
//  GoTDemoApp
//
//  Created by Coding on 10/15/21.
//  Copyright © 2021 Vaporstream. All rights reserved.
//

import UIKit

class HouseAttributeCollectionViewCell: UICollectionViewCell {
    
    //MARK: - properties
    static let identifier = "HouseAttributeCollectionViewCell"
    
    public let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    public let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    //MARK: - lifecycle
    
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        clipsToBounds = true
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.sizeToFit()
        subTitleLabel.sizeToFit()
        titleLabel.frame = CGRect(x: contentView.width/20, y: contentView.height/2 - titleLabel.height/2, width: titleLabel.width, height: titleLabel.height)
        
        subTitleLabel.sizeToFit()
        subTitleLabel.frame = CGRect(x: titleLabel.right + 10, y: contentView.height/2 - subTitleLabel.height/2, width: subTitleLabel.width, height: subTitleLabel.height)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        subTitleLabel.text = nil
    }
}
