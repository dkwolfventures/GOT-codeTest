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
    private var lord: Character?
    private var heir: Character?
    private var allCharacters: [Character] = []
    private var allUrls: [String] = []
    private var houseAttributes = [String:String]()
    
    private var collectionView: UICollectionView?
    
    private lazy var spacing = (view.width / 20)
    
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
        
        configureHouseChars()
        configureHouseAttributes()
        fetchCharacters()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    //MARK: - actions
    
    //MARK: - helpers
    
    private func configureHouseAttributes(){
        self.houseAttributes = house.houseAttributes()
    }
    
    private func configureHouseChars(){
        
        if house.swornMembers.count > 0 {
            for member in house.swornMembers {
                allUrls.append(member)
            }
        }
        
    }
    
}

//MARK: - UICollectionViewDelegate & UICollectionViewDataSource


extension HouseDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
            
        case 0:
            return houseAttributes.count
            
        case 1:
            return 2
            
        case 2:
            
            return allCharacters.count
            
        default:
            
            fatalError()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = indexPath.section
        
        switch section {
        case 0:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HouseAttributeCollectionViewCell.identifier, for: indexPath) as! HouseAttributeCollectionViewCell
            
            let index = houseAttributes.index(houseAttributes.startIndex, offsetBy: indexPath.row)
            cell.titleLabel.text = houseAttributes.keys[index]
            cell.subTitleLabel.text = houseAttributes.values[index]
            
            return cell
            
        case 1:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LeadershipCollectionViewCell.identifier, for: indexPath) as! LeadershipCollectionViewCell
            
            if indexPath.row == 0 {
                
                if let lord = lord {
                    
                    let viewModel = LeadershipCellViewModel(character: lord)
                    
                    cell.configure(with: indexPath.row, viewModel: viewModel)
                    
                } else {
                    cell.leaderTitleLabel.text = "No Lord"
                }
                
            } else if indexPath.row == 1 {
                
                if let heir = heir {
                    
                    let viewModel = LeadershipCellViewModel(character: heir)
                    cell.configure(with: indexPath.row, viewModel: viewModel)
                } else {
                    cell.leaderTitleLabel.text = "No Heir"
                }
            }
            
            return cell
            
        case 2:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SwornMemberCollectionViewCell.identifier, for: indexPath) as! SwornMemberCollectionViewCell
            
            cell.nameLabel.text = allCharacters[indexPath.row].name
            
            return cell
            
        default:
            fatalError()
        }
        
    }


}

//MARK: - fetchCharacters

extension HouseDetailViewController {
    
    private func fetchCharacters(){
        
        let characterGroup = DispatchGroup()
        
        var allCharacters: [Character] = []
        
        let currentLord = house.currentLord != ""
        let currentHeir = house.heir != ""

        if currentLord {
            characterGroup.enter()
            APICaller.shared.fetchCharacter(characterUrl: house.currentLord) { result in
                
                defer {
                    characterGroup.leave()
                }
                
                switch result {
                case .success(let currentLord):
                    self.lord = currentLord
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        if currentHeir {
            characterGroup.enter()
            APICaller.shared.fetchCharacter(characterUrl: house.heir) { result in
                
                defer {
                    characterGroup.leave()
                }
                
                switch result {
                case .success(let heir):
                    self.heir = heir
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        if allUrls.count > 2 {
            for x in 2..<allUrls.count {
                characterGroup.enter()
                APICaller.shared.fetchCharacter(characterUrl: allUrls[x]) { [weak self] result in
                    defer {
                        characterGroup.leave()
                    }
                    
                    switch result {
                    case .success(let swornMember):
                        
                        if swornMember.name != self?.lord?.name || swornMember.name != self?.heir?.name {
                            allCharacters.append(swornMember)
                        }
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
        
        characterGroup.notify(queue: .main) {
            self.allCharacters = allCharacters
            DispatchQueue.main.async {
                self.setUpCollectionView()
            }
        }
        
    }
    
}

//MARK: - setUpCollectionView

extension HouseDetailViewController {
    
    private func setUpCollectionView(){
        let layout = UICollectionViewCompositionalLayout { section, _ in
            return self.layout(for: section)
        }
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.register(HouseAttributeCollectionViewCell.self, forCellWithReuseIdentifier: HouseAttributeCollectionViewCell.identifier)
        collectionView.register(LeadershipCollectionViewCell.self, forCellWithReuseIdentifier: LeadershipCollectionViewCell.identifier)
        collectionView.register(SwornMemberCollectionViewCell.self, forCellWithReuseIdentifier: SwornMemberCollectionViewCell.identifier)

        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        self.collectionView = collectionView
    }
    
    private func layout(for section: Int) -> NSCollectionLayoutSection {
        
        var numOfTitles: CGFloat {
            return CGFloat(lord == nil ? 0 : lord!.titles.count)
        }
        
        switch section {
            
        case 0:
            
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0)
            
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(40)),
                subitems: [item])
            
            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: spacing)
            
            let sectionLayout = NSCollectionLayoutSection(group: group)
        
            sectionLayout.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0)
            
            return sectionLayout
            
        case 1:
            
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
               
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.75),
                    heightDimension: .fractionalWidth(0.75)),
                subitem: item,
                count: 1)
            
            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: spacing)
                
            //section layou
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .continuous
            return sectionLayout
            
        case 2:
            
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0)
            
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(40)),
                subitems: [item])
            
            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: spacing)
            
            let sectionLayout = NSCollectionLayoutSection(group: group)
        
            sectionLayout.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 0)
            
            return sectionLayout
            
        default:
            fatalError()
        }
    }
    
}
