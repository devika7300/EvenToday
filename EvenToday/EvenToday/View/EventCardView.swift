//
//  EventCardView.swift
//  EvenToday
//
//  Created by Devika Shendkar on 5/5/23.
//

import SwiftUI

struct EventCardView: View {
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading) {
            //Spacer()
            Image( "marriage")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 200)
                .cornerRadius(10)
                 
            Text(event.name)
                .font(.headline)
           
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct EventCardView_Previews: PreviewProvider {
    static var previews: some View {
        let event = Event(ownerId: "sampleOwnerId", name: "Sample Event", date: Date(), time: Date(), eventType: "Birthday", budget: 100, description: "Sample description")
                return EventCardView(event: event)
    }
}
