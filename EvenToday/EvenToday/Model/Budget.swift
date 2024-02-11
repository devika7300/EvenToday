//
//  Budget.swift
//  EvenToday
//
//  Created by Devika Shendkar on 5/6/23.
//



import Foundation

struct Budget {
    let totalBudget: Double
    var availableBalance: Double
    var recentActivity: [RecentActivity]

    init(totalBudget: Double) {
        self.totalBudget = totalBudget
        self.availableBalance = totalBudget
        self.recentActivity = []
    }

    mutating func addRecentActivity(title: String, amount: Double) {
        let activity = RecentActivity(title: title, amount: amount)
        recentActivity.append(activity)
        availableBalance -= amount
    }
}

struct RecentActivity: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let amount: Double
}


