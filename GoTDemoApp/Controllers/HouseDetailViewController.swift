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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        
        for member in house.swornMembers {
            allUrls.append(member)
        }
        
    }
    
    private func showAlert(){
        
        let alert = UIAlertController(title: "Uh Oh!", message: "There was an issue loading the data for this page. Would you like to try again?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Reload", style: .default, handler: { [weak self] _ in
            self?.fetchCharacters()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true)
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
                    cell.configureForNoData(with: indexPath.row)
                }
                
            } else if indexPath.row == 1 {
                
                if let heir = heir {
                    
                    let viewModel = LeadershipCellViewModel(character: heir)
                    cell.configure(with: indexPath.row, viewModel: viewModel)
                } else {
                    cell.configureForNoData(with: indexPath.row)
                }
            }
            
            return cell
            
        case 2:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SwornMemberCollectionViewCell.identifier, for: indexPath) as! SwornMemberCollectionViewCell
            
            cell.viewModel = SwornMembersViewModel(char: allCharacters[indexPath.row])
            
            
            return cell
            
        default:
            fatalError()
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DetailSectionHeaderCollectionReusableView.identifier, for: indexPath) as! DetailSectionHeaderCollectionReusableView
        
        let section = indexPath.section

        switch (section) {
        
        case 0:
            
            header.configure(with: section, nil)
            return header
        case 1:
            
            header.configure(with: section, nil)
            return header
        case 2:
            
            header.configure(with: section, true)
            return header
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
            APICaller.shared.fetchCharacter(characterUrl: house.currentLord) { [weak self] result in
                
                defer {
                    characterGroup.leave()
                }
                
                switch result {
                case .success(let currentLord):
                    self?.lord = currentLord
                    
                case .failure(_):
                    self?.showAlert()
                }
            }
        }
        
        if currentHeir {
            characterGroup.enter()
            APICaller.shared.fetchCharacter(characterUrl: house.heir) { [weak self] result in
                
                defer {
                    characterGroup.leave()
                }
                
                switch result {
                case .success(let heir):
                    self?.heir = heir
                    
                case .failure(_):
                    self?.showAlert()
                }
            }
        }
        
        for x in 0..<allUrls.count {
            characterGroup.enter()
            APICaller.shared.fetchCharacter(characterUrl: allUrls[x]) { [weak self] result in
                defer {
                    characterGroup.leave()
                }
                
                switch result {
                case .success(let swornMember):
                    
                    if swornMember.name != self?.lord?.name || swornMember.name != self?.heir?.name{
                        allCharacters.append(swornMember)
                    }
                    
                case .failure(_):
                    self?.showAlert()
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
        collectionView.register(DetailSectionHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailSectionHeaderCollectionReusableView.identifier)
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
            
            sectionLayout.boundarySupplementaryItems = [
                NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(30)),
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top)
            ]
            
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
            
            sectionLayout.boundarySupplementaryItems = [
                NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(30)),
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top)
            ]
            
                sectionLayout.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0)
                
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
        
            sectionLayout.boundarySupplementaryItems = [
                NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(30)),
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top)
            ]
            
            return sectionLayout
            
        default:
            fatalError()
        }
    }
    
}
