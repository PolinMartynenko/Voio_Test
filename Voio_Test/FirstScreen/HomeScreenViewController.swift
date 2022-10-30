//
//  ViewController.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 08.10.2022.
//

import UIKit

class HomeScreenViewController: UIViewController {
    
    let viewModel: HomeScreenViewModel
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    init(viewModel:HomeScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "YouTube API"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        view.backgroundColor = .darkBackgroundColor
        setupCollectionView()
        viewModel.viewDidLoad()
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .darkBackgroundColor
        
        collectionView.register(HomeScreenCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseId)
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        collectionView.register(SecondCollectionViewCell.self, forCellWithReuseIdentifier: "cellSecond")
        collectionView.register(SecondCollectionViewCell.self, forCellWithReuseIdentifier: "second_cell")
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10)
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
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6),heightDimension: .fractionalHeight(0.3))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 12, leading: 15, bottom: 0, trailing: 0)
        
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
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HomeScreenCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.imageView.image = UIImage(named: viewModel.thirdSectionItems[indexPath.row])
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}

extension HomeScreenViewController: UICollectionViewDelegate {
    
}
