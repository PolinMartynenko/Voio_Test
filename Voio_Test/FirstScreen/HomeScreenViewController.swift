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
        
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HomeScreenCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.addSubview(collectionView)
        collectionView.layer.cornerRadius = 15
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10)
        ])
        collectionView.collectionViewLayout = createCompositionalLayout()
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {

        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            switch sectionNumber {
                case 0: return self.firstLayoutSection()
//                case 1: return self.secondLayoutSection()
                default: return self.firstLayoutSection()
//                return self.thirdLayoutSection()
            }
       }
    }
    
    private func firstLayoutSection() -> NSCollectionLayoutSection {

       let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:
    .fractionalHeight(1))

       let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets.bottom = 15

       let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension:
    .fractionalWidth(0.5))

       let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    group.contentInsets = .init(top: 0, leading: 15, bottom: 0, trailing: 2)

       let section = NSCollectionLayoutSection(group: group)

       section.orthogonalScrollingBehavior = .groupPaging
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

       return section
    }
    
}

extension HomeScreenViewController: HomeScreenViewModelDelegate {
}

extension HomeScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
}

extension HomeScreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
