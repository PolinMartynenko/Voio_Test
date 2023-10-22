//
//  MyPlaylistScreenViewController.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 11.03.2023.
//

import Foundation
import UIKit
import GoogleAPIClientForREST
import GoogleSignIn
import FirebaseCore
import FirebaseAuth
import Firebase
import FirebaseAnalytics

class MyPlaylistScreenViewController: UIViewController {
    
    var viewModel: MyPlaylistScreenViewModel
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let playerButton = UIButton()
    let navigationBarAppearance = UINavigationBarAppearance()
    let settings = UIImage(named: "Settings")?.withRenderingMode(.alwaysOriginal)
    
    
    init(viewModel: MyPlaylistScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkBackgroundColor
        setupCollectionView()
        setupPlayerButton()
        
        navigationItem.title = "My Playlists"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
        
        
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .darkBackgroundColor
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: settings, style:.plain, target: self, action: #selector(settingsButtonTouched))
        
        viewModel.onViewDidLoad()
        
    }
    
    @objc func settingsButtonTouched() {
        let settingsVC = SettingsModule.build()
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    func setupPlayerButton() {
        playerButton.backgroundColor = .pinkColor
        playerButton.layer.cornerRadius = 10
        playerButton.setImage(UIImage(named: "Close&Open-1"), for: .normal)
        view.addSubview(playerButton)
//        playerButton.addTarget(self, action: #selector(self.playerButtonTouched), for: .touchUpInside)
        playerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            playerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            playerButton.heightAnchor.constraint(equalToConstant: 45),
            playerButton.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        playerButton.setNeedsLayout()
        playerButton.layoutIfNeeded()
    }
    
//    @objc func playerButtonTouched(_ playerButton: UIButton){
//        guard let item = viewModel.selectedItem, let id = viewModel.selectedItem?.myPlaylist.identifier else {
//            return
//        }
//
//        let playerItem = PlayerItem(videoId: id)
//        let playerVC = PlayerScreenModule.build(playerItem)
//        present(playerVC, animated: true, completion: nil)
//        print("Touched")
//    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .darkBackgroundColor
        collectionView.alwaysBounceVertical = true
        
        collectionView.register(MyPlaylistCollectionViewCell.self, forCellWithReuseIdentifier: MyPlaylistCollectionViewCell.reuseId)
        
        collectionView.register(MyPlaylistHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MyPlaylistHeaderCollectionReusableView.identifier)
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        collectionView.collectionViewLayout = createCompositionalLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MyPlaylistHeaderCollectionReusableView.identifier, for: indexPath) as! MyPlaylistHeaderCollectionReusableView
        let playlist = Array(viewModel.sectionItems.keys)[indexPath.section]
        let title = playlist.snippet?.title
       
        header.configure(text: title)
        return header
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            switch sectionNumber {
            case 0: return self.firstLayoutSection()
            case 1: return self.secondLayoutSection()
            case 2: return self.thirdLayoutSection()
            case 3: return self.secondLayoutSection()
            case 4: return self.thirdLayoutSection()
            default: return self.firstLayoutSection()
            }
        }
    }
    
    private func firstLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.bottom = 10
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .fractionalHeight(0.4))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 15, leading: 15, bottom: 0, trailing: 15)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    private func secondLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),heightDimension: .fractionalHeight(0.3))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 10, leading: 15, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [headerElement]
        
        return section
    }
    
    private func thirdLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),heightDimension: .fractionalHeight(0.2))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 11, leading: 15, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [headerElement]
        
        return section
    }
}

extension MyPlaylistScreenViewController: MyPlaylistScreenViewModelDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
}

extension MyPlaylistScreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var item:  GTLRYouTube_PlaylistItem
       let key = Array(viewModel.sectionItems.keys)[indexPath.section]
        if let items = viewModel.sectionItems[key] {
            viewModel.selectedItem = items[indexPath.row]
        } else {
            return
        }
        
        
    guard let items = viewModel.selectedItem,
              let videoId = items.snippet?.resourceId?.videoId else {
            return
        }
        
        let playerItem = PlayerItem(videoId: videoId)
        
        
        let playerVC = PlayerScreenModule.build(playerItem, items: [])
        present(playerVC, animated: true, completion: nil)
    }
}


extension MyPlaylistScreenViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sectionItems.keys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let key = Array(viewModel.sectionItems.keys)[section]
        if let values = viewModel.sectionItems[key] {
            return values.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPlaylistCollectionViewCell.reuseId, for: indexPath) as? MyPlaylistCollectionViewCell else {
            return UICollectionViewCell() }
        let key = Array(viewModel.sectionItems.keys)[indexPath.section]
        if let items = viewModel.sectionItems[key] {
            cell.setup(items[indexPath.row])
            return cell
        }
        return cell
    }
    
}
