
//
//  TaskViewModel.swift
//  EvenToday
//
//  Created by Devika Shendkar on 5/4/23.
//

import Foundation
import FirebaseDatabase
import Firebase
class TaskViewModel: ObservableObject {
    @Published var tasks = [Task]()
   @Published var uid = Auth.auth().currentUser?.uid
    
    
    func addTasks(eventType: String) {
        var newTasks: [Task] = []
        
        switch eventType {
        case "Birthday":
            newTasks = [
                Task(title: "Birthday Planning", isChecked: false),
                Task(title: "Order cake", isChecked: false),
                Task(title: "Buy Balloons", isChecked: false),
                Task(title: "Buy Candle", isChecked: false),
                Task(title: "Buy Gifts", isChecked: false),
                Task(title: "Book Location", isChecked: false)
            ]
            
        case "Marriage":
            newTasks = [
                Task(title: "Marriage Planning", isChecked: false),
                Task(title: "Order cake", isChecked: false),
                Task(title: "Book Location", isChecked: false),
                Task(title: "Buy Decoration", isChecked: false),
                Task(title: "Buy Gifts", isChecked: false)
            ]
            
        case "Cultural":
            newTasks = [
                Task(title: "Cultural Event Planning", isChecked: false),
                Task(title: "Book Location", isChecked: false),
                Task(title: "Buy Decoration", isChecked: false),
                Task(title: "Buy Sound System", isChecked: false)
            ]
            
        // Add cases for other event types and define the corresponding tasks
        default:
            newTasks = []
        }
        let tasksRef = Database.database().reference().child("tasks").child(uid ?? "")
            
            for task in newTasks {
                let taskData: [String: Any] = [
                    "title": task.title,
                    "isChecked": task.isChecked
                ]
                
                tasksRef.childByAutoId().setValue(taskData)
            }
            
    }
    
    
    func fetchTasks() {
        let tasksRef = Database.database().reference().child("tasks").child(uid ?? "")
        tasksRef.observeSingleEvent(of: .value) { snapshot in
            var fetchedTasks: [Task] = []
            
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let taskDict = snapshot.value as? [String: Any] {
                    if let title = taskDict["title"] as? String,
                       let isChecked = taskDict["isChecked"] as? Bool {
                        let task = Task(title: title, isChecked: isChecked)
                        fetchedTasks.append(task)
                    }
                }
            }
            
            // Update the tasks property of the ViewModel
            DispatchQueue.main.async {
                self.tasks = fetchedTasks
            }
        }
    }

    func deleteTask(at offsets: IndexSet, uid: String) {
           let tasksToDelete = offsets.map { tasks[$0] }
           let tasksRef = Database.database().reference().child("tasks").child(uid ?? "")
           
           for task in tasksToDelete {
               tasksRef.child(task.id).removeValue()
           }
       }



}


