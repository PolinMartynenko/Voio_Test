//
//  SearchScreenViewControoller.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 26.02.2023.
//

import Foundation
import SDWebImage
import UIKit

class SearchResultTableViewCell: UITableViewCell {
    private let titleLabel = UILabel()
    private let iconView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ item: PlaylistlItem) {
        titleLabel.text = item.playlist.snippet?.title
        if let path = item.playlist.snippet?.thumbnails?.high?.url, let url = URL(string: path) {
            iconView.sd_setImage(with: url, completed: nil)
        }
    }
    
    private func setupLayout() {
        contentView.backgroundColor = .darkBackgroundColor
        iconView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(iconView)
        iconView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            iconView.heightAnchor.constraint(equalToConstant: 60),
            iconView.widthAnchor.constraint(equalToConstant: 80),
            iconView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            iconView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            iconView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(titleLabel)
        titleLabel.font = UIFont(name: "Poppins-Regular", size: 17)
        titleLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor, constant: -5),
            titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
        ])
    }
}

class SearchScreenViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var viewModel: SearchScreenViewModel
    var tableView = UITableView()
    
    init(viewModel: SearchScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = UIColor.systemPink
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view.addSubview(tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.playlistItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SearchResultTableViewCell
        else { return UITableViewCell() }
        cell.setup(viewModel.playlistItems[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.playlistItems[indexPath.row]
        guard let videoId = item.playlist.identifier?.videoId else {
            return
        }
        
        let playerItem = PlayerItem(videoId: videoId)
        let playterItems = viewModel.playlistItems.compactMap { playlistItem -> PlayerItem? in
            guard let videoID = playlistItem.playlist.identifier?.videoId else {
                return nil
            }
            
            return PlayerItem(videoId: videoID)
        }
        
        let playerVC = PlayerScreenModule.build(playerItem, items: playterItems)
        present(playerVC, animated: true)
    }
}

extension SearchScreenViewController: SearchScreenViewModelDelegate {
    func reloadData() {
        tableView.reloadData()
    }
}

extension SearchScreenViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.onDidChangeText(searchText)
    
    }
}
