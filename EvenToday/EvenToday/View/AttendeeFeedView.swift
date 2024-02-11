//
//  AttendeeFeedView.swift
//  EvenToday
//
//  Created by Devika Shendkar on 5/7/23.
//

import SwiftUI

struct AttendeeFeedView: View {
    @StateObject private var eventViewModel = EventViewModel()
    @State private var showAddEventView = false
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(eventViewModel.events) { event in
                        NavigationLink(destination: AttendeeEventDetailsView(event: event)) {
                            EventCardView(event: event)
                        }
                    }
                }
            }
            .navigationBarTitle("Home Feed")
            
            Spacer()
            
        }
        .onAppear {
            eventViewModel.fetchAllEvents()
        }
    }
}

struct AttendeeFeedView_Previews: PreviewProvider {
    static var previews: some View {
        AttendeeFeedView()
    }
}
