//
//  GuestView.swift
//  EvenToday
//
//  Created by Devika Shendkar on 5/4/23.
//

import SwiftUI

struct GuestView: View {
    @State private var attendeeCount = 0
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Attendee")
                    .font(.custom("Georgia-Bold", size: 20))
                    .foregroundColor(Color(hex: "FF5C58"))
                    .padding(.leading, 30)
                
                Spacer()
            }
            .padding(.top, 30)
            
            Image("guests")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding(.top, 30)
            
            VStack {
                Text("0")
                    .font(.custom("Gotu-Regular", size: 34))
                    .foregroundColor(Color(hex: "FF5C58"))
                
                Text("Attendee goal")
                    .font(.custom("Gotu-Regular", size: 20))
                    .foregroundColor(Color(hex: "FF5C58"))
            }
            .padding(.top, 30)
            
            HStack {
                VStack {
                    Text("0")
                        .font(.custom("Gotu-Regular", size: 34))
                        .foregroundColor(Color(hex: "FF5C58"))
                    
                    Text("Attendee RSVP'd")
                        .font(.custom("Gotu-Regular", size: 20))
                        .foregroundColor(Color(hex: "FF5C58"))
                }
                
                Spacer()
                
                VStack {
                    Text("\(attendeeCount)") // Display the attendee count
                                        .font(.custom("Gotu-Regular", size: 34))
                                        .foregroundColor(Color(hex: "FF5C58"))
                    
                    Text("Attendee coming")
                        .font(.custom("Gotu-Regular", size: 20))
                        .foregroundColor(Color(hex: "FF5C58"))
                }
            }
            .padding(.top, 10)
            
            Spacer()
            
            HStack {
                Spacer()
                
                NavigationLink(destination: ContactView()) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color(hex: "FF5C58"))
                        .padding(20)
                }
            }
            .background(Color.white)
        }
    }
}



struct GuestView_Previews: PreviewProvider {
    static var previews: some View {
        GuestView()
    }
}

