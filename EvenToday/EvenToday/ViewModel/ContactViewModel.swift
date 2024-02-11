//
//  ContactViewModel.swift
//  EvenToday
//
//  Created by Devika Shendkar on 5/6/23.
//


import Foundation
import UIKit
import Contacts
enum PermissionsError: Identifiable {
    var id: String { UUID().uuidString }
    case userError
    case fetchError(Error)
    
    var description: String {
        switch self {
        case .userError:
            return "Please change permissions in settings."
        case .fetchError(let error):
            return error.localizedDescription
        }
    }
}

final class ContactViewModel: ObservableObject {
    @Published var contacts: [ContactsM] = []
    @Published var permissionsError: PermissionsError?
    
    init() {
        permissions()
    }
    
    func openSettings() {
        permissionsError = nil
        guard let settingURL = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingURL) {
            UIApplication.shared.open(settingURL)
        }
    }
    
    private func getContacts() {
        ContactsM.fetchAll { result in
            switch result {
            case .success(let fetchedContacts):
                DispatchQueue.main.async {
                    self.contacts = fetchedContacts.sorted(by: { $0.lastName < $1.lastName })
                }
            case .failure(let error):
                self.permissionsError = .fetchError(error)
            }
        }
    }
    private func permissions() {
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            getContacts()
            
        case .notDetermined, .restricted, .denied:
            CNContactStore().requestAccess(for: .contacts) { [weak self] granted, error in
                guard let self = self else { return }
                switch granted {
                case true:
                    self.getContacts()
                case false:
                    DispatchQueue.main.async {
                        self.permissionsError = .userError
                    }
                }
            }
            
        default:
            fatalError("Unknown error")
        }
    }
}
