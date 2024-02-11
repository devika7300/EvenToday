//
//  ContactView.swift
//  EvenToday
//
//  Created by Devika Shendkar on 5/6/23.
//


import SwiftUI

struct ContactView: View {
    @StateObject private var contactsVM = ContactViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(contactsVM.contacts) { contact in
                    VStack(alignment: .leading) {
                        HStack {
                            Label(contact.firstName, systemImage: "person.crop.circle")
                            Text(contact.lastName).bold()
                            Divider()
                            Label(contact.phone ?? "not provided", systemImage: "phone")
                        }
                        .padding()
                        .background(Color.secondary.opacity(0.25))
                        .clipShape(RoundedRectangle(cornerRadius: 15.8, style: .continuous))
                    }
                }
                .navigationTitle("Contacts")
            }
            .alert(item: $contactsVM.permissionsError) { error in
                Alert(
                    title: Text("Permission denied"),
                    message: Text(error.description),
                    dismissButton: .default(Text("OK"), action: { contactsVM.openSettings() })
                )
            }
        }
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView()
    }
}

