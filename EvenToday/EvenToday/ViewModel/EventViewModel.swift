//
//  EventViewModel.swift
//  EvenToday
//
//  Created by Devika Shendkar on 5/5/23.
//

import Foundation
import Firebase
import FirebaseStorage



class EventViewModel: ObservableObject {
    @Published var events: [Event] = []
    
    private let databaseRef = Database.database().reference().child("events")
    @Published var uid = Auth.auth().currentUser?.uid
    
   

    func addEvent(ownerId: String, name: String, date: Date, time: Date, eventType: String, budget: Int, description: String, completion: @escaping (Error?) -> Void) {
        let event = Event(ownerId: ownerId, name: name, date: date, time: time, eventType: eventType, budget: budget, description: description)
        do {
            let eventData = try JSONEncoder().encode(event)
            let eventJSON = try JSONSerialization.jsonObject(with: eventData) as? [String: Any]
            databaseRef.child(uid ?? "").child(event.id).setValue(eventJSON) { error, _ in
                completion(error)
            }
        } catch {
            completion(error)
        }
    }
    
   
        
        func fetchEvents() {
            // Fetch events from Realtime Firebase and update the events array
            let databaseRef = Database.database().reference().child("events").child(uid ?? "")
            databaseRef.observeSingleEvent(of: .value) { snapshot in
                var fetchedEvents: [Event] = []
                for child in snapshot.children {
                    if let snapshot = child as? DataSnapshot,
                       let eventDict = snapshot.value as? [String: Any] {
                        if let eventData = try? JSONSerialization.data(withJSONObject: eventDict),
                           let event = try? JSONDecoder().decode(Event.self, from: eventData) {
                            fetchedEvents.append(event)
                        }
                    }
                }
                self.events = fetchedEvents
            }
        }
    
    func fetchAllEvents() {
        // Fetch events from Realtime Firebase and update the events array
        let databaseRef = Database.database().reference().child("events").child(uid ?? "")
        databaseRef.observeSingleEvent(of: .value) { snapshot in
            var fetchedEvents: [Event] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let eventDict = snapshot.value as? [String: Any] {
                    if let eventData = try? JSONSerialization.data(withJSONObject: eventDict),
                       let event = try? JSONDecoder().decode(Event.self, from: eventData) {
                        fetchedEvents.append(event)
                    }
                }
            }
            self.events = fetchedEvents
        }
    }

    
}




