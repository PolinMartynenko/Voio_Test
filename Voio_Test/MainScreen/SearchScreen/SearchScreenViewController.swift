//
//  SearchScreenViewControoller.swift
//  Voio_Test
//
//  Created by Polina Martynenko on 26.02.2023.
//

import Foundation
import UIKit


class SearchScreenViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var viewModel: SearchScreenViewModel
    var dataModel = ["Dog", "Frog", "Jirafe", "Cat", "Monkey"]
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
        return dataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = dataModel[indexPath.row]
        
        return cell
    }
}

extension SearchScreenViewController: SearchScreenViewModelDelegate {
    func reloadData() {
    }
}

extension SearchScreenViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.onDidChangeText(searchText)
        print(searchText)
    }
    
}
