//
//  ViewController.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 08.10.2022.
//

import UIKit



class HomeScreenViewController: UIViewController {

    var viewModel: HomeScreenViewModel
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let playerButton = UIButton()
    let backArrowImage = UIImage(named: "left-arrow")
    let searchScreenVC = SearchScreenModule.build()
    lazy var searchController = UISearchController(searchResultsController: searchScreenVC)
    let navigationBarAppearance = UINavigationBarAppearance()

    
    init(viewModel:HomeScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "YouTube Videous"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
//        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = searchScreenVC
        searchController.searchBar.placeholder = "Search playlists"
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barTintColor = .white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = UIColor.white
        
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .darkBackgroundColor
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        

        view.backgroundColor = .darkBackgroundColor
        setupBackArrowButton()
        setupCollectionView()
        setupPlayerButton()
        viewModel.viewDidLoad()
    }
    
//    func updateSearchResults(for searchController: UISearchController) {
//        guard let text = searchController.searchBar.text else {
//            return
//        }
//        let vc = searchController.searchResultsController as? SearchScreenViewController
//        vc?.view.backgroundColor = .yellow
//        print(text)
//    }
    
    private func setupBackArrowButton() {
        let arrowBackButton = UIBarButtonItem(image: backArrowImage, style:.plain, target: self, action: #selector(backToWelcomeScreen))
        arrowBackButton.tintColor = .pinkColor
        navigationItem.leftBarButtonItem = arrowBackButton
    }
    
    @objc func backToWelcomeScreen() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupPlayerButton() {
        playerButton.backgroundColor = .pinkColor
        playerButton.layer.cornerRadius = 10
        playerButton.setImage(UIImage(named: "Close&Open-1"), for: .normal)
        view.addSubview(playerButton)
        playerButton.addTarget(self, action: #selector(self.playerButtonTouched), for: .touchUpInside)
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
    
    @objc func playerButtonTouched(_ playerButton: UIButton){
        guard let videoId = viewModel.selectedItem?.playlist.identifier?.videoId else {
            return
        }
        
        let playerItem = PlayerItem(videoId: videoId)
        let playterItems = viewModel.selectedSectionItems.compactMap { playlistItem -> PlayerItem? in
            guard let videoID = playlistItem.playlist.identifier?.videoId else {
                return nil
            }
            
            return PlayerItem(videoId: videoID)
        }
        let playerVC = PlayerScreenModule.build(playerItem, items: playterItems)
        present(playerVC, animated: true, completion: nil)
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .darkBackgroundColor
        
        collectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseId)
        
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        
        collectionView.register(SecondCollectionViewCell.self, forCellWithReuseIdentifier: SecondCollectionViewCell.reuseId)
        
        collectionView.register(ThirdCollectionViewCell.self, forCellWithReuseIdentifier: ThirdCollectionViewCell.reuseId)
        
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
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView
    
        header.configure()
        return header
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            switch sectionNumber {
            case 0: return self.firstLayoutSection()
            case 1: return self.secondLayoutSection()
            default: return self.thirdLayoutSection()
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
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),heightDimension: .fractionalHeight(0.4))
        
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

extension HomeScreenViewController: HomeScreenViewModelDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
}

extension HomeScreenViewController: UICollectionViewDataSource {
    func numberOfSections(in: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.firstSectionItems.count
        } else if section == 1 {
            return viewModel.secondSectionItems.count
        } else {
            return viewModel.thirdSectionItems.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.reuseId, for: indexPath) as? GalleryCollectionViewCell else {
                return UICollectionViewCell()
            }
            let playlistItem = viewModel.firstSectionItems[indexPath.row]
            cell.setup(playlistItem)
            
            return cell
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondCollectionViewCell.reuseId, for: indexPath) as? SecondCollectionViewCell else {
                return UICollectionViewCell()
            }
            let secondListItem = viewModel.secondSectionItems[indexPath.row]
            cell.setup(secondListItem)
            return cell
            
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThirdCollectionViewCell.reuseId, for: indexPath) as? ThirdCollectionViewCell else {
                return UICollectionViewCell()
            }
            let thirdListItem = viewModel.thirdSectionItems[indexPath.row]
            cell.setup(thirdListItem)
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}

extension HomeScreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var item: PlaylistlItem?
        var items = [PlaylistlItem]()
        switch indexPath.section {
        case 0:
            items = viewModel.firstSectionItems
        case 1:
            items = viewModel.secondSectionItems
        case 2:
            items = viewModel.thirdSectionItems
        default:
            break
        }
        
        item = items[indexPath.row]
        viewModel.selectedSectionItems = items
        viewModel.selectedItem = item
        
        guard let item = viewModel.selectedItem,
              let videoId = item.playlist.identifier?.videoId else {
                  return
              }
        
        
        let playerItem = PlayerItem(videoId: videoId)
        let playterItems = items.compactMap { playlistItem -> PlayerItem? in
            guard let videoID = playlistItem.playlist.identifier?.videoId else {
                return nil
            }
            
            return PlayerItem(videoId: videoID)
        }
        
        let playerVC = PlayerScreenModule.build(playerItem, items: playterItems)
        present(playerVC, animated: true, completion: nil)
    }
}

extension UISearchBar {
    func setTextColor(color: UIColor) {
        let svs = subviews.flatMap { $0.subviews }
        guard let tf = (svs.filter { $0 is UITextField }).first as? UITextField else { return }
        tf.textColor = color
    }
}
