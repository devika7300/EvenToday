//
//  AuthViewModel.swift
//  EvenToday
//
//  Created by Devika Shendkar on 5/3/23.
//

import Foundation
import Firebase

class AuthViewModel: ObservableObject {
    
    // Published properties to update the View as the user authentication status changes
    @Published var user: User?
    @Published var isAuthenticating = false
    @Published var error: Error?
    @Published var userData: UserData?
    private let db = Database.database().reference()
    
    
    // Function to sign in the user with their email and password
    func signIn(email: String, password: String) {
        // Set the isAuthenticating property to true to show that authentication is in progress
        self.isAuthenticating = true
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            DispatchQueue.main.async {
                // Set isAuthenticating to false once authentication is complete
                self.isAuthenticating = false
                if let error = error {
                    // If there was an error, set the error property so the View can display it
                    self.error = error
                    return
                }
                // If authentication was successful, set the user property so the View can display the user's email address
                self.user = result?.user
                
                
            }
        }
    }
    
    // Function to sign up a new user with their email and password
    func signUp(email: String, password: String,name:String){
        self.isAuthenticating = true
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            DispatchQueue.main.async {
                self.isAuthenticating = false
                if let error = error {
                    self.error = error
                    return
                }
                // If the user was successfully created, add the user to the Realtime Database
                if let user = result?.user {
                    let userData = ["email": user.email ?? "","name": name ]
                    Database.database().reference().child("users").child(user.uid).setValue(userData)
                    self.user = user
                    
                    
                }
            }
        }
    }
    func signOut() throws{
        try Auth.auth().signOut()
    }
    
    
    func fetchUserData() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userRef = db.child("users").child(uid)
        userRef.observeSingleEvent(of: .value) { (snapshot: DataSnapshot)  in
            guard let value = snapshot.value as? [String: Any] else { return }
            let name = value["name"] as? String ?? ""
            let email = value["email"] as? String ?? ""
            let userData = UserData(email: email,name: name)
            self.userData = userData
        }
    }
    
    
}
