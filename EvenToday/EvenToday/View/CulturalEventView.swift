//
//  CulturalEventView.swift
//  EvenToday
//
//  Created by Devika Shendkar on 5/4/23.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct CulturalEventView: View {
    @State private var eventTitle = ""
    @State private var eventDate: Date = Date()
    @State private var eventTime = Date()
    @State private var additionalInfo = ""
    @State private var budget = ""
    @StateObject var eventViewModel = EventViewModel()
    @State var ownerId = Auth.auth().currentUser?.uid
    @State private var isEventCreated = false
    @State private var taskViewModel = TaskViewModel()
    var body: some View {
        NavigationView {
            contentView
                .padding()
                .navigationTitle("Create Cultural Event")
                .background(Color(hex: "FFE6E6"))
            .fullScreenCover(isPresented: $isEventCreated) {
                HostDashboard()
            }
        }
    }
    
    private var contentView: some View {
        VStack(spacing: 10) {
            eventImage
            Text("Cultural Event")
                .font(.title2)
            eventTitleField
            dateAndTimePicker
            additionalInfoSection
            budgetField
            Spacer()
            createEventButton
        }
    }
    
    private var eventImage: some View {
        Image("cultural")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 200, height: 200)
    }
    
    private var eventTitleField: some View {
        TextField("Event Title", text: $eventTitle)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
    
    private var dateAndTimePicker: some View {
        HStack {
            DatePicker("Event Date", selection: $eventDate, displayedComponents: .date)
                .datePickerStyle(.compact)
                .frame(height: 50)
            
            DatePicker("Event Time", selection: $eventTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(.compact)
                .frame(height: 50)
        }
    }
    
    private var additionalInfoSection: some View {
        VStack(alignment: .leading) {
            Text("Additional Information")
                .font(.headline)
            TextEditor(text: $additionalInfo)
                .frame(height: 100)
                .border(Color.gray, width: 1)
        }
    }
    
    private var budgetField: some View {
        VStack(alignment: .leading) {
            Text("Suitable Budget")
                .font(.headline)
            TextField("Enter budget", text: $budget)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
        }
    }
    
    private var createEventButton: some View {
        Button(action: {
            guard let ownerId = ownerId, let budgetValue = Int(budget) else { return }
            eventViewModel.addEvent(ownerId: ownerId, name: eventTitle, date: eventDate, time: eventTime, eventType: "Cultural", budget: budgetValue, description: additionalInfo) { error in
                if let error = error {
                    print("Error: \(error)")
                    // Handle the error as needed
                } else {
                    print("Data added")
                    isEventCreated = true
                    // Add tasks to the Realtime Database
                   taskViewModel.addTasks(eventType: "Marriage")
                    taskViewModel.fetchTasks()
    
                }
            }
        }) {
            Text("Create Event")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
        }
    }
}

struct CulturalEventView_Previews: PreviewProvider {
    static var previews: some View {
        CulturalEventView()
    }
}
