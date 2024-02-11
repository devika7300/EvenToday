//
//  BudgetViewModel.swift
//  EvenToday
//
//  Created by Devika Shendkar on 5/6/23.
//

import Foundation
import Firebase
import Combine

class BudgetViewModel: ObservableObject {
    @Published var totalBudget: Int = 0
        private var cancellables = Set<AnyCancellable>()
        private let eventViewModel = EventViewModel()
    private let db = Database.database().reference()
    @Published var activities: [RecentActivity] = []
    var currentBalance: Double {
        Double(totalBudget) - activities.reduce(0, { $0 + $1.amount })
        }

        init() {
            fetchTotalBudget()
            fetchActivities()
        }

        func fetchTotalBudget() {
            eventViewModel.$events
                .sink { [weak self] events in
                    guard let self = self else { return }

                    var total = 0

                    for event in events {
                        total += event.budget
                    }

                    DispatchQueue.main.async {
                        self.totalBudget = total
                    }
                }
                .store(in: &cancellables)

            eventViewModel.fetchEvents()
        }
    
    func addSpending(_ recentActivity: RecentActivity) {
            guard let uid = Auth.auth().currentUser?.uid else { return }

        let activityData = ["title": recentActivity.title, "amount": recentActivity.amount] as [String : Any]
            db.child("activities").child(uid).childByAutoId().setValue(activityData)
        }
    
    func fetchActivities() {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            
            db.child("activities").child(uid).observe(.value) { [weak self] snapshot in
                guard let self = self else { return }
                
                var fetchedActivities: [RecentActivity] = []
                
                for child in snapshot.children {
                    if let childSnapshot = child as? DataSnapshot,
                       let activityData = childSnapshot.value as? [String: Any],
                       let title = activityData["title"] as? String,
                       let amount = activityData["amount"] as? Double {
                        let activity = RecentActivity(title: title, amount: amount)
                        fetchedActivities.append(activity)
                    }
                }
                
                self.activities = fetchedActivities
            }
        }
    
    
}



