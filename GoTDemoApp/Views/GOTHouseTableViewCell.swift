//
//  GOTHouseTableViewCell.swift
//  GoTDemoApp
//
//  Created by Coding on 10/14/21.
//  Copyright © 2021 Vaporstream. All rights reserved.
//

import UIKit

class GOTHouseTableViewCell: UITableViewCell {
    
    //MARK: - properties
    static let identifier = "GOTHouseTableViewCell"
    
    var viewModel: HouseViewModel?{
        didSet{configureCell()}
    }
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let wordsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    private let membersIcon: UIView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "person.3")
        iv.tintColor = .label
        return iv
    }()
           
    private let membersLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
     
    //MARK: - lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(wordsLabel)
        contentView.addSubview(membersIcon)
        contentView.addSubview(membersLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let standardPadding = contentView.width / 20
        let memberIconSize = CGSize(width: (contentView.height/3) * 2, height: contentView.height/3)

        nameLabel.sizeToFit()
        nameLabel.frame = CGRect(x: standardPadding, y: 4, width: contentView.width - memberIconSize.width - (standardPadding * 2), height: nameLabel.height)
        
        wordsLabel.frame = CGRect(x: nameLabel.left, y: nameLabel.bottom + 4, width: contentView.width - memberIconSize.width - 20, height: nameLabel.height)

        membersIcon.frame = CGRect(x: contentView.width - memberIconSize.width - standardPadding , y: contentView.height/2 - membersIcon.height/2, width: memberIconSize.width, height: memberIconSize.height)
        
        membersLabel.sizeToFit()
        membersLabel.frame = CGRect(x: membersIcon.left + membersIcon.width/2 - 5, y: membersIcon.bottom, width: membersLabel.width, height: membersLabel.height)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = nil
        wordsLabel.text = nil
        membersLabel.text = nil
        
    }
    
    //MARK: - helpers
    
    private func configureCell(){
        guard let viewModel = viewModel else {
            return
        }
        
        nameLabel.text = viewModel.name
        wordsLabel.text = viewModel.words
        membersLabel.text = "\(viewModel.numberOfMembers)"
        
    }
    
}
