//
//  SwornMemberCollectionViewCell.swift
//  GoTDemoApp
//
//  Created by Coding on 10/15/21.
//  Copyright © 2021 Vaporstream. All rights reserved.
//

import UIKit

class SwornMemberCollectionViewCell: UICollectionViewCell {
    
    //MARK: - properties
    static let identifier = "SwornMemberCollectionViewCell"
    
    var viewModel: SwornMembersViewModel?{
        didSet{configure()}
    }
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    //MARK: - lifecycle
    
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        clipsToBounds = true
        contentView.addSubview(nameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.sizeToFit()
        nameLabel.frame = CGRect(x: contentView.width/20, y: contentView.height/2 - nameLabel.height/2, width: nameLabel.width, height: nameLabel.height)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = ""
    }
    
    public func configure(){
        
        guard let viewModel = viewModel else {
            return
        }
        
        nameLabel.text = viewModel.name
    }
    
    public func configOffIdx(){
        nameLabel.text = nil
    }
}
