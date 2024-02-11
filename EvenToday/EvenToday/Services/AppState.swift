//
//  AppState.swift
//  EvenToday
//
//  Created by Devika Shendkar on 5/3/23.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var currentScreen: Screen = .login
    
    enum Screen {
        case login
        case dashboard
    }
}
