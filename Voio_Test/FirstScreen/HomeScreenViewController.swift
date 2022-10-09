//
//  ViewController.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 08.10.2022.
//

import UIKit

class HomeScreenViewController: UIViewController {
    
    let viewModel: HomeScreenViewModel
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: HomeScreenViewController.)
    
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


       }
    }
    
}




extension HomeScreenViewController: HomeScreenViewModelDelegate {
}
