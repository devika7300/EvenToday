//
//  TaskView.swift
//  EvenToday
//
//  Created by Devika Shendkar on 5/4/23.
//



import SwiftUI
import Firebase

struct TaskView: View {
    @StateObject var taskViewModel = TaskViewModel()
    @State var newTaskTitle = ""
   // @State var uid = Auth.auth().currentUser?.uid
    
    var eventType: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Tasks")
                .font(.system(size: 30, weight: .bold, design: .default))
                .foregroundColor(Color(hex: "FF5C58"))
                .padding(.horizontal)
                .padding(.top, 50)
            
            List {
                ForEach(taskViewModel.tasks.indices, id: \.self) { index in
                    let task = taskViewModel.tasks[index]
                    HStack {
                        Toggle("", isOn: $taskViewModel.tasks[index].isChecked)
                            .toggleStyle(SwitchToggleStyle(tint: Color.green))
                        TextField("Task", text: $taskViewModel.tasks[index].title)
                    }
                }
                .onDelete(perform: deleteTask)
            }
            .listStyle(PlainListStyle())
            .padding()

           
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
           
                taskViewModel.fetchTasks()
           
                }
        
         
    }
    
    func deleteTask(at offsets: IndexSet) {
            if let uid = Auth.auth().currentUser?.uid {
                taskViewModel.deleteTask(at: offsets, uid: uid)
            }
        }
}


struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(eventType: "Birthday")
    }
}
