//
//  MostViewedViewModel.swift
//  InformTehnikaTZ
//
//  Created by Александр Гужавин on 07.06.2023.
//

import Foundation
import Contacts

protocol MostViewedViewModelType: AnyObject {
    var contacts: [Contact] { get }
    var selectedContacts: [Contact] { get }
    func getContacts(_ completion: @escaping (Bool) -> Void)
    func addSelectedContact(_ indexPath: IndexPath)
    func removeSelectedContact(_ indexPath: IndexPath) -> Bool
}

class MostViewedViewModel: MostViewedViewModelType {
    private var contactsCN: [CNContact] = []
    var selectedContacts: [Contact] = []
    var contacts: [Contact] {
        FetchContacts.convertToContacts(from: contactsCN)
    }
    
    func getContacts(_ completion: @escaping (Bool) -> Void) {
        
        FetchContacts.getContacts { [weak self] (contactsCN, bool) in
            self?.contactsCN = contactsCN
            completion(bool)
        }
    }
    
    func addSelectedContact(_ indexPath: IndexPath) {
        selectedContacts.append(contacts[indexPath.row])
    }
    
    func removeSelectedContact(_ indexPath: IndexPath) -> Bool {
        let contactSelect = selectedContacts.first { contact in
            contact.phone == contacts[indexPath.row].phone || contact.fullName == contacts[indexPath.row].fullName
        }
        selectedContacts.removeAll { contact in
            contact.phone == contactSelect!.phone
        }
        return true
    }
}
