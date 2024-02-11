//
//  SignUpView.swift
//  EvenToday
//
//  Created by Devika Shendkar on 5/3/23.
//

import SwiftUI

struct SignUpView: View {
    @StateObject var authView = AuthViewModel()
    
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var isLoginPresented = false
    @State private var signUpSuccess = false
    @State private var isSignUpActionPresented = false
    
    var body: some View {
        if authView.user != nil{
            LoginView()
        }
        else{
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer().frame(height: 160)
                    
                    Text("EvenToday")
                        .font(.custom("Georgia-Bold", size: 24))
                        .foregroundColor(Color(hex: "FF5C58"))
                        .frame(width: 145, height: 50)
                        .padding(.top, 50)
                    
                    VStack {
                        TextField("Full Name", text: $fullName)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color(hex: "DEDED4")))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(hex: "FFFFFF"), lineWidth: 1))
                            .padding(.horizontal, 20)
                            .autocapitalization(.words)
                            .textContentType(.name)
                        
                        
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
                    }.padding(.top, 40)
                    
                    if let error = authView.error {
                        // If there is an error, display it in red text
                        Text(error.localizedDescription)
                            .foregroundColor(.red)
                    }
                    
                    
                    Button("Sign Up") {
                        authView.signUp(email: email, password: password,name: fullName)
                        
                    } .font(.system(size: 24))
                        .foregroundColor(.white)
                        .padding(.horizontal, 80)
                        .padding(.vertical, 12)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color(hex: "FF5151")))
                        .padding(.top, 30)
                    
                    
                    HStack {
                        Text("Already have an account?")
                            .font(.custom("GilSans", size: 20))
                        Button(action: {
                            isLoginPresented.toggle() // Open login page
                        }) {
                            Text("Login")
                                .underline()
                                .foregroundColor(.blue)
                                .font(.custom("GilSans", size: 20))
                        }
                        .sheet(isPresented: $isLoginPresented) {
                            LoginView() // Present login page
                        }
                    }.padding(.top, 30)
                    
                    Spacer()
                }
            }.padding()
            // Disable the view and reduce opacity if authentication is in progress
                .disabled(authView.isAuthenticating)
                .opacity(authView.isAuthenticating ? 0.5 : 1)
                .navigationBarBackButtonHidden(true)
        }
    }
    
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = Double((rgbValue & 0xff0000) >> 16) / 255.0
        let g = Double((rgbValue & 0xff00) >> 8) / 255.0
        let b = Double(rgbValue & 0xff) / 255.0

        self.init(red: r, green: g, blue: b)
    }
}




struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
