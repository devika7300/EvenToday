//
//  Task.swift
//  EvenToday
//
//  Created by Devika Shendkar on 5/4/23.
//



import Foundation
struct Task: Decodable,Identifiable {
    let id : String
    var title: String
    var isChecked: Bool
    
    init(title: String, isChecked: Bool) {
        self.id = UUID().uuidString
        self.title = title
        self.isChecked = isChecked
        
    }
}



