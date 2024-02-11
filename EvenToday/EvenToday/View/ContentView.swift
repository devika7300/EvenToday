//
//  ContentView.swift
//  EvenToday
//
//  Created by Devika Shendkar on 4/18/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LoginView()
            .environmentObject(AppState())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
