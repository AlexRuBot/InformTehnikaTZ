//
//  SearchController.swift
//  InformTehnikaTZ
//
//  Created by Александр Гужавин on 07.06.2023.
//

import UIKit

class SearchController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let searchViewModel: SearchViewModelType = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        tableView.register(ContactCell.self, forCellReuseIdentifier: ContactCell.indentifier)
        searchViewModel.getContacts { bool in
            print(bool)
            self.tableView.reloadData()
        }
    }
}

extension SearchController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchViewModel.filteredContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.indentifier, for: indexPath) as! ContactCell
        cell.selectionStyle = .none
        cell.setContact(contact: searchViewModel.filteredContacts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let visibleCells = tableView.visibleCells.count == 0 ? 1 : tableView.visibleCells.count
        var deley = 0.2
        
        if indexPath.row >= 10 {
            deley *= Double(indexPath.row % visibleCells)
        } else {
            deley *= Double(indexPath.row) / 10
        }
        
        cell.transform = CGAffineTransform(translationX: 0, y: cell.contentView.frame.height)
        
        UIView.animate(withDuration: 0.25, delay : deley, animations: {
            cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: cell.contentView.frame.height)
        })
    }
}

extension SearchController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            searchViewModel.clearFilter()
        } else {
            searchViewModel.filterContacts(with: searchText)
        }
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
