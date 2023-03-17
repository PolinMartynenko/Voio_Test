//
//  MyPlaylistScreenViewController.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 11.03.2023.
//

import Foundation
import UIKit

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
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: settings, style:.plain, target: nil, action: nil)
        
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .pinkColor
        collectionView.alwaysBounceVertical = true
        
        collectionView.register(MyPlaylistCollectionViewCell.self, forCellWithReuseIdentifier: MyPlaylistCollectionViewCell.reuseId)
        
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
//        collectionView.collectionViewLayout = createCompositionalLayout()
    }
}


extension MyPlaylistScreenViewController: MyPlaylistScreenViewModelDelegate {
    
}

extension MyPlaylistScreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
        }
}

extension MyPlaylistScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPlaylistCollectionViewCell.reuseId, for: indexPath) as? MyPlaylistCollectionViewCell else {
          return UICollectionViewCell() }
        return cell
    }
    
}
