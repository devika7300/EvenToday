import SwiftUI
import MessageUI
import Contacts

struct ContactListView: View {
    @StateObject var viewModel = ContactListViewModel()
    
    var body: some View {
        VStack {
            SearchBar(text: $viewModel.searchText)
                .padding(.horizontal)
            
            List(viewModel.filteredContacts) { contact in
                ContactRow(contact: contact)
                    .onTapGesture {
                        viewModel.selectContact(contact)
                    }
            }
        }
    }
}

struct ContactRow: View {
    var contact: Contact
    
    var body: some View {
        HStack {
            Text(contact.displayName)
            Spacer()
            if contact.isSelected {
                Image(systemName: "checkmark")
                    .foregroundColor(.blue)
            }
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button(action: {
                text = ""
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
            }
            .padding(.trailing)
            .opacity(text.isEmpty ? 0 : 1)
        }
    }
}

class ContactListViewModel: NSObject, ObservableObject, MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        print("successfull")
    }
    
    @Published var searchText = ""
    @Published var contacts = [Contact]()
    
   
    
    var filteredContacts: [Contact] {
        if searchText.isEmpty {
            return contacts
        } else {
            return contacts.filter { $0.displayName.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func fetchContacts() {
        let store = CNContactStore()
        let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactEmailAddressesKey, CNContactPhoneNumbersKey]
        let request = CNContactFetchRequest(keysToFetch: keysToFetch as [CNKeyDescriptor])
        
        do {
            try store.enumerateContacts(with: request) { contact, _ in
                let displayName = "\(contact.givenName) \(contact.familyName)"
                let emailAddresses = contact.emailAddresses.map { $0.value as String }
                let phoneNumbers = contact.phoneNumbers.map { $0.value.stringValue }
                let newContact = Contact(displayName: displayName, emailAddresses: emailAddresses, phoneNumbers: phoneNumbers)
                contacts.append(newContact)
            }
        } catch {
            print("Failed to fetch contacts: \(error)")
        }
    }

    
    func selectContact(_ contact: Contact) {
        if let index = contacts.firstIndex(where: { $0.displayName == contact.displayName }) {
            contacts[index].isSelected.toggle()
        }
    }
    
    func sendInvitations() {
            let selectedContacts = contacts.filter { $0.isSelected }
            
            for contact in selectedContacts {
                for phoneNumber in contact.phoneNumbers {
                    sendSMS(to: phoneNumber, message: "You're invited to the event!")
                }
            }
        }
        
    private func sendSMS(to phoneNumber: String, message: String) {
        if MFMessageComposeViewController.canSendText() {
            let composeVC = MFMessageComposeViewController()
            composeVC.recipients = [phoneNumber]
            composeVC.body = message
            composeVC.messageComposeDelegate = UIApplication.shared.delegate as? AppDelegate as! any MFMessageComposeViewControllerDelegate
            
            // Present the message compose view controller
            UIApplication.shared.windows.first?.rootViewController?.present(composeVC, animated: true, completion: nil)
        } else {
            // Handle the case where the device can't send SMS
            // Display an error message or fallback to another method
        }
    }

}

struct Contact: Identifiable {
    let id = UUID()
    let displayName: String
    let emailAddresses: [String]
    let phoneNumbers: [String]
    var isSelected = false
    // ...
}

struct EventInvitationView: View {
    @ObservedObject var contactListViewModel = ContactListViewModel()
    
    var body: some View {
        VStack {
            Text("Invite Attendees")
                .font(.largeTitle)
                .padding()
            
            ContactListView(viewModel: contactListViewModel)
            
            Button(action: {
                contactListViewModel.sendInvitations()
            }) {
                Text("Send Invitations")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            
            Spacer()
        }
    }
}

struct EventInvitationView_Previews: PreviewProvider {
    static var previews: some View {
        EventInvitationView()
    }
}
