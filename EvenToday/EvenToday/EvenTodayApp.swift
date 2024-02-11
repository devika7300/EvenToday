//
//  EvenTodayApp.swift
//  EvenToday
//
//  Created by Devika Shendkar on 4/18/23.
//

import SwiftUI
import Firebase

@main
struct EvenTodayApp: App {
    @StateObject var authView = AuthViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            if Auth.auth().currentUser != nil {
                            // User is signed in, show the main app view
                LoginButtonAction()
                    .environmentObject(authView)
                        } else {
                            // User is signed out, show the sign-in view
                            LoginView()
                                .environmentObject(authView)
                        }
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      print("Configured Firebase!")
    return true
  }
}
