//
//  MostViewedController.swift
//  InformTehnikaTZ
//
//  Created by Александр Гужавин on 07.06.2023.
//

import UIKit

class MostViewedController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let mostViewedViewModel: MostViewedViewModelType = MostViewedViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SelectedContactsCell.self, forCellReuseIdentifier: SelectedContactsCell.identifier)
        tableView.register(SelectableContactCell.self, forCellReuseIdentifier: SelectableContactCell.identifier)

        mostViewedViewModel.getContacts { bool in
            print(bool)
            self.tableView.reloadData()
        }
    }
}

extension MostViewedController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return mostViewedViewModel.selectedContacts.count > 0 ? 1 : 0
        } else {
            return mostViewedViewModel.contacts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SelectedContactsCell.identifier, for: indexPath) as! SelectedContactsCell
            cell.configure(with: mostViewedViewModel.selectedContacts)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: SelectableContactCell.identifier, for: indexPath) as! SelectableContactCell
            cell.setContact(contact: mostViewedViewModel.contacts[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section != 0 {
            let cell = tableView.cellForRow(at: indexPath) as! SelectableContactCell
            if cell.selectCell() {
                mostViewedViewModel.addSelectedContact(indexPath)
                tableView.reloadSections(IndexSet(integer: 0), with: .none)
            } else if mostViewedViewModel.removeSelectedContact(indexPath) {
                tableView.reloadSections(IndexSet(integer: 0), with: .none)
                }
        }
    }
    
    
    
    
}
