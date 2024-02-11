//
//  EventDetailsView.swift
//  EvenToday
//
//  Created by Devika Shendkar on 5/4/23.
//

import SwiftUI
struct EventDetailsView: View {
    var event: Event
   
    var body: some View {
        VStack(alignment: .leading) {
            EventHeaderView(event: event)
          
            Spacer()
        }
        .padding()
    }
}

struct EventHeaderView: View {
    var event: Event
   
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "marriage")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 200)
                .cornerRadius(10)
            
            Text("Birthday Event")
                //.font(.title2)
                .font(.custom("Georgia", size: 20))
                .foregroundColor(Color(hex: "FF5C58"))

            
            Text(event.name)
                .font(.custom("Georgia", size: 12))
                .foregroundColor(Color(hex: "FF5C58"))
                .fontWeight(.bold)
            
            Text("Event Date: \(formattedDate(Date(timeIntervalSince1970: event.date / 1000)))").font(.custom("Georgia", size: 12))
                .foregroundColor(Color(hex: "FF5C58"))

            
            Text("Event Time: \(formattedTime(Date(timeIntervalSince1970: event.time / 1000)))").font(.custom("Georgia", size: 12))
                .foregroundColor(Color(hex: "FF5C58"))

            
            Text("Additional Information")
                .font(.headline).font(.custom("Georgia", size: 15))
                .foregroundColor(Color(hex: "FF5C58"))

            
            Text(event.description)
                .font(.custom("Georgia", size: 12))
                .foregroundColor(Color(hex: "FF5C58"))
                .padding(.top, 10)
            
            
            
           
            
        }
    }
    
    func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
    
    func formattedTime(_ time: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: time)
    }
}

struct EventDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        
        return EventDetailsView(event: Event(ownerId: "sampleOwnerId", name: "Sample Event", date: Date(), time: Date(), eventType: "Birthday", budget: 100, description: "Sample description"))//, budgetViewModel: budgetViewModel)
    }
}


