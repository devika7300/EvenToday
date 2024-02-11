//
//  HostDashboard.swift
//  EvenToday
//
//  Created by Devika Shendkar on 5/3/23.
//

import SwiftUI
import Firebase

struct HostDashboard: View {
    @EnvironmentObject var appState: AppState
    @State private var isShowingLoginView = false
    @EnvironmentObject var authViewModel : AuthViewModel
    
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
               

                Button(action: {
                    do {
                        try authViewModel.signOut()
                        isShowingLoginView = true
                    } catch {
                        print("Error signing out: \(error)")
                    }
                }) {
                    Image(systemName: "arrow.backward.square")
                        .foregroundColor(.red)
                        .imageScale(.large)
                }
                .fullScreenCover(isPresented: $isShowingLoginView) {
                    NavigationStack {
                        LoginView()
                    }
                }

            }
            
            TabView {
                HomeFeedView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home Feed")
                    }
                BudgetView()
                    .tabItem {
                        Image(systemName: "dollarsign.circle")
                        Text("Budget")
                    }
                GuestView()
                    .tabItem {
                        Image(systemName: "person.3")
                        Text("Guests")
                    }
                TaskView(eventType: "Birthday")
                    .tabItem {
                        Image(systemName: "checkmark.circle")
                        Text("Tasks")
                    }
               
            }
        }
        .padding()
        .navigationBarTitle("Dashboard")
        .navigationBarHidden(true)
    }
}

struct CircleButtonStyle: ButtonStyle {
    var label: String
    
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.label
                .foregroundColor(.primary)
            Text(label)
                .font(.subheadline)
                .foregroundColor(.primary)
        }
        .padding()
        .background(Color(hex: "F3C8C8"))
        .clipShape(Circle())
        .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

struct HostDashboard_Previews: PreviewProvider {
    static var previews: some View {
        HostDashboard()
    }
}
