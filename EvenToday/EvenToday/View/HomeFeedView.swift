//
//  HomeFeedView.swift
//  EvenToday
//
//  Created by Devika Shendkar on 5/5/23.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct HomeFeedView: View {
    @StateObject private var eventViewModel = EventViewModel()
    @State private var showAddEventView = false
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(eventViewModel.events) { event in
                        NavigationLink(destination: EventDetailsView(event: event)) {
                            EventCardView(event: event)
                        }
                    }
                }
            }
            .navigationBarTitle("Home Feed")
            
            Spacer()
            
            Button(action: {
                self.showAddEventView.toggle()
            }) {
                Text("+")
                    .font(.system(size: 40))
                    .frame(width: 80, height: 80)
                    .background(Color(hex: "F3C8C8"))
                    .foregroundColor(Color(hex: "FF5C58"))
                    .clipShape(Circle())
            }
        }
        .sheet(isPresented: $showAddEventView) {
            AddEventView()
        }
        .onAppear {
            eventViewModel.fetchEvents()
        }
    }
}

struct HomeFeedView_Previews: PreviewProvider {
    static var previews: some View {
        HomeFeedView()
    }
}
