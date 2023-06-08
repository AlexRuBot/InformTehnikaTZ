//
//  FetchContacts.swift
//  InformTehnikaTZ
//
//  Created by Александр Гужавин on 07.06.2023.
//

import Foundation
import Contacts

struct FetchContacts {
    
    static func getContacts(completion: @escaping ([CNContact], Bool) -> Void) {
        var contacts = [CNContact]()
        let contactStore = CNContactStore()
        let keys: [CNKeyDescriptor] = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
                                       CNContactPhoneNumbersKey,
                                       CNContactThumbnailImageDataKey] as [Any] as! [CNKeyDescriptor]
        
        DispatchQueue.global(qos: .background).async {
            let request = CNContactFetchRequest(keysToFetch: keys)
            request.sortOrder = .userDefault
            
            do {
                try contactStore.enumerateContacts(with: request){
                        (contact, stop) in
                    contacts.append(contact)
                }
            } catch {
                print("unable to fetch contacts")
                DispatchQueue.main.async {
                    completion(contacts, false)
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(contacts, true)
            }
        }
    }
    
    static func convertToContacts(from cnContacts: [CNContact]) -> [Contact] {
        var contacts = [Contact]()
        cnContacts.forEach { cnContact in
            let fullName = cnContact.givenName == "" && cnContact.familyName == "" ? cnContact.organizationName : cnContact.givenName + " " + cnContact.familyName
            
            contacts.append(Contact(fullName: fullName,
                                    phone: cnContact.phoneNumbers.first?.value.stringValue,
                                    image: cnContact.thumbnailImageData))
        }
        return contacts
    }
}
