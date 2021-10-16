//
//  LeadershipCollectionViewCell.swift
//  GoTDemoApp
//
//  Created by Coding on 10/15/21.
//  Copyright © 2021 Vaporstream. All rights reserved.
//

import UIKit

class LeadershipCollectionViewCell: UICollectionViewCell {
    
    //MARK: - properties
    static let identifier = "LeadershipCollectionViewCell"
    
    var viewModel: LeadershipCellViewModel?
    
    let leaderTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private var dobLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var titlesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: - lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(leaderTitleLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(dobLabel)
        contentView.addSubview(titlesLabel)
        
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        leaderTitleLabel.sizeToFit()
        leaderTitleLabel.frame = CGRect(x: contentView.width/2 - leaderTitleLabel.width/2, y: 10, width: leaderTitleLabel.width, height: leaderTitleLabel.height)
        
        nameLabel.sizeToFit()
        nameLabel.frame = CGRect(x: contentView.width/2 - nameLabel.width/2, y: leaderTitleLabel.bottom + 10, width: nameLabel.width, height: nameLabel.height)
        
        dobLabel.sizeToFit()
        dobLabel.anchor(top: nameLabel.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 10, paddingLeft: 15, paddingRight: 15)
        
        titlesLabel.sizeToFit()
        titlesLabel.anchor(top: dobLabel.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 10, paddingLeft: 15, paddingRight: 15)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        leaderTitleLabel.text = nil
        nameLabel.text = nil
        dobLabel.text = nil
        titlesLabel.text = nil
        
    }
    
    //MARK: - helpers
    
    public func configure(with index: Int, viewModel: LeadershipCellViewModel){
        
        leaderTitleLabel.text = "Lord"
        
        if index == 1 {
            leaderTitleLabel.text = "Heir"
        }
        
        nameLabel.text = viewModel.name
        dobLabel.text = viewModel.born.replacingOccurrences(of: "In", with: "Born:")
        titlesLabel.text = viewModel.titleOrTitles + ":\n" + viewModel.titles.joined(separator: ",\n")
    }
}
