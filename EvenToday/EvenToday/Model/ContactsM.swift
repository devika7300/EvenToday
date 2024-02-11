//
//  ContactsM.swift
//  EvenToday
//
//  Created by Devika Shendkar on 5/6/23.
//

import Foundation
import Contacts

struct ContactsM: Identifiable {
    var id: String { contact.identifier }
    var firstName: String { contact.givenName }
    var lastName: String { contact.familyName }
    var phone: String? { contact.phoneNumbers.first?.value.stringValue }
    let contact: CNContact

    static func fetchAll(completion: @escaping (Result<[ContactsM], Error>) -> Void) {
        let containerID = CNContactStore().defaultContainerIdentifier()
        let predicate = CNContact.predicateForContactsInContainer(withIdentifier: containerID)
        let descriptor: [CNKeyDescriptor] = [
            CNContactIdentifierKey as CNKeyDescriptor,
            CNContactGivenNameKey as CNKeyDescriptor,
            CNContactFamilyNameKey as CNKeyDescriptor,
            CNContactPhoneNumbersKey as CNKeyDescriptor
        ]

        do {
            let rawContacts = try CNContactStore().unifiedContacts(matching: predicate, keysToFetch: descriptor)
            let contacts = rawContacts.map { ContactsM(contact: $0) }
            completion(.success(contacts))
        } catch {
            completion(.failure(error))
        }
    }
}

