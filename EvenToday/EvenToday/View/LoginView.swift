//
//  LoginView.swift
//  EvenToday
//
//  Created by Devika Shendkar on 5/3/23.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth

struct LoginView: View {
    // Create an instance of the ViewModel
    @StateObject private var viewModel = AuthViewModel()

    @State private var email = ""
    @State private var password = ""
    @State private var isSignUpPresented = false
    @State private var isLoginButtonPressed = false
    
    @StateObject private var googleSignInViewModel = GoogleSignInButtonViewModel(scheme: .light, style: .wide, state: .normal)

    
    var body: some View {
        if viewModel.user != nil {
            // If there is a user signed in, display a welcome message and a button to sign out
            LoginButtonAction()
        }
        // If there is no user signed in, display text fields for the email and password, as well as buttons to sign in and sign up
        else{
        
            NavigationView {
                ZStack {
                    Color.white.edgesIgnoringSafeArea(.all)
                    VStack {
                        Spacer().frame(height: 250)
                        
                        Text("EvenToday")
                            .font(.custom("Georgia-Bold", size: 24))
                            .foregroundColor(Color(hex: "FF5C58"))
                        //.frame(width: 145, height: 50)
                        //.padding(.top, 50)
                        // .position(x: 110, y: 0)
                        
                        VStack {
                            TextField("Email", text: $email)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color(hex: "DEDED4")))
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(hex: "FFFFFF"), lineWidth: 1))
                                .padding(.horizontal, 20)
                                .autocapitalization(.none)
                                .keyboardType(.emailAddress)
                                .textContentType(.emailAddress)
                            
                            SecureField("Password", text: $password)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color(hex: "DEDED4")))
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(hex: "FFFFFF"), lineWidth: 1))
                                .padding(.horizontal, 20)
                                .textContentType(.password)
                        }
                        .padding(.top, 30)
                        
                        if let error = viewModel.error {
                            // If there is an error, display it in red text
                            Text(error.localizedDescription)
                                .foregroundColor(.red)
                        }
                        
                        Button("Sign In") {
                            viewModel.signIn(email: email, password: password)
                        }.font(.system(size: 24))
                            .foregroundColor(.white)
                            .padding(.horizontal, 80)
                            .padding(.vertical, 12)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color(hex: "FF5151")))
                            .padding(.top,30)
                        
                     
                        
                        HStack {
                            Text("Don't have an account?")
                                .font(.custom("GilSans", size: 20))
                            Button(action: {
                                isSignUpPresented.toggle() // Open sign-up page
                            }) {
                                Text("Sign up")
                                    .underline()
                                    .foregroundColor(.blue)
                                    .font(.custom("GilSans", size: 20))
                            }
                            .sheet(isPresented: $isSignUpPresented) {
                                SignUpView() // Present sign-up page
                            }
                        }.padding(.top, 30)
                        
                        Spacer()
                    }
                }.padding()
                // Disable the view and reduce opacity if authentication is in progress
                .disabled(viewModel.isAuthenticating)
                .opacity(viewModel.isAuthenticating ? 0.5 : 1)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
