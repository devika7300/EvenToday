//
//  Event.swift
//  EvenToday
//
//  Created by Devika Shendkar on 5/4/23.
//

import Foundation

struct Event: Encodable, Decodable,Identifiable {
    
    let id: String
    let ownerId: String
    let name: String
    let date: TimeInterval
    let time: TimeInterval
    let eventType: String
    let budget: Int
    let description: String
    
    
    init(ownerId: String, name: String, date: Date, time: Date, eventType: String, budget: Int, description: String) {
        self.id = UUID().uuidString
        self.ownerId = ownerId
        self.name = name
        self.date = date.timeIntervalSince1970*1000
        self.time = time.timeIntervalSince1970*1000
        self.eventType = eventType
        self.budget = budget
        self.description = description
    }
    
  
}
   
