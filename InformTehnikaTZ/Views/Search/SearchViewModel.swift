//
//  SearchViewModel.swift
//  InformTehnikaTZ
//
//  Created by Александр Гужавин on 07.06.2023.
//

import Foundation
import Contacts

protocol SearchViewModelType: AnyObject {
    var contacts: [Contact] { get }
    var filteredContacts: [Contact] { get }
    func getContacts(_ completion: @escaping (Bool) -> Void)
    func filterContacts(with searchText: String)
    func clearFilter()
}

class SearchViewModel: SearchViewModelType {
    private var contactsCN: [CNContact] = []
    var contacts: [Contact] {
        FetchContacts.convertToContacts(from: contactsCN)
    }
    var filteredContacts: [Contact] = []
    
    func getContacts(_ completion: @escaping (Bool) -> Void) {
        
        FetchContacts.getContacts { [weak self] (contactsCN, bool) in
            self?.contactsCN = contactsCN
            self?.filteredContacts = self?.contacts ?? []
            completion(bool)
        }
        
    }
    
    func filterContacts(with searchText: String) {
        filteredContacts = contacts.filter { contact in
            guard let phone = contact.phone else {
                return contact.fullName.lowercased().contains(searchText.lowercased())
            }
            return contact.fullName.lowercased().contains(searchText.lowercased()) || phone.lowercased().contains(searchText.lowercased())
        }
        
    }
    
    func clearFilter() {
        filteredContacts = contacts
    }
}
