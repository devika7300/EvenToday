//
//  AttedeeDashboard.swift
//  EvenToday
//
//  Created by Devika Shendkar on 5/3/23.
//

import SwiftUI

struct AttedeeDashboard: View {
    var body: some View {
        TabView {
            //AttendeeHomeFeedView()
            AttendeeFeedView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            UpcomingEventsView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Upcoming Events")
                }
        }
        .background(Color(hex: "FFE6E6"))
        .accentColor(.green) // set the tab bar tint color
        .navigationBarTitle("", displayMode: .inline) // remove the default title and set the display mode to inline
    }
}

struct AttendeeHomeFeedView: View {
  
    
    @State private var selectedEvent: Event?
  
    var body: some View {
        GeometryReader { geometry in
            let screen = UIScreen.main.bounds
          
        }
    }
}

struct EventCardView1: View {
    var event: Event
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: "trash")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .clipped()
            VStack(alignment: .leading, spacing: 5) {
                Text(event.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                    Text("Date: ")
                        .fontWeight(.bold)
              
            }

            HStack {
                Spacer()
                Button(action: {
                    // code to handle checkout button tap
                }) {
                    Text("Checkout")
                        .font(Font.custom("Georgia-Bold", size: 18))
                               .foregroundColor(Color(hex: "FF5C58"))
                               .frame(width: 120, height: 40)
                               .background(Color(hex: "F3C8C8"))
                               .cornerRadius(20)
                }
            }
        }
        .padding()
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}



struct UpcomingEventsView: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Upcoming events")
                    .font(.custom("Georgia-Bold", size: 28))
                    .foregroundColor(Color(hex: "FF5C58"))
                    .padding(.leading, 30)
                
                Spacer()
            }
            .padding(.top, 30)
            
            Image("celebration")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .padding(.top, 30)
            
            Spacer()
        }
    }
}






