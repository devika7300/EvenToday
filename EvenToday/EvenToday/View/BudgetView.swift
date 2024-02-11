//
//  BudgetView.swift
//  EvenToday
//
//  Created by Devika Shendkar on 5/4/23.
//

import SwiftUI
struct BudgetView: View {
    @ObservedObject var budgetViewModel = BudgetViewModel()
    @State private var title: String = ""
    @State private var amount: String = ""

    var body: some View {
        VStack(spacing: 0) {
            Text("Budget")
                .font(.custom("Georgia-Bold", size: 28))
                .foregroundColor(Color(hex: "FF5C58"))
                .padding(.top, 30)

           

            Text("Total Budget: \(budgetViewModel.totalBudget)")
                        .onAppear {
                            budgetViewModel.fetchTotalBudget()
                        }
                .font(.custom("Georgia", size: 28))
                .foregroundColor(Color(hex: "FF5C58"))

            // Rest of the code...

            Text("Recent Activity")
                            .font(.custom("Georgia-Bold", size: 20))
                            .foregroundColor(Color(hex: "FF5C58"))
                            .padding(.top, 20)
                            .padding(.horizontal, 30)
                        
                        List(budgetViewModel.activities, id: \.self) { activity in
                            HStack {
                                Text(activity.title)
                                    .font(.custom("Georgia", size: 12))
                                    .foregroundColor(Color(hex: "FF5C58"))
                                
                                Spacer()
                                
                                Text("-$\(activity.amount, specifier: "%.2f")")
                                    .font(.custom("Georgia", size: 12))
                                    .foregroundColor(Color(hex: "FF5C58"))
                            }
                        }
                        .padding(.horizontal, 30)
            
            HStack{
                
                
                
                Text("Current Balance: \(budgetViewModel.currentBalance, specifier: "%.2f")")
                    .font(.custom("Georgia", size: 18))
                    .foregroundColor(Color(hex: "FF5C58"))
                    .padding(.top, 10)
                
            }
            HStack {
                TextField("Title", text: $title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                TextField("Amount", text: $amount)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)

                Button(action: {
                    if let amount = Double(amount) {
                        let activity = RecentActivity(title: title, amount: amount)
                       budgetViewModel.addSpending(activity)
                        title = ""
                        self.amount = ""
                    }
                }) {
                    Text("Add Spending")
                }
                .buttonStyle(BorderlessButtonStyle())
            }
            .padding()
            .padding(.horizontal, 30)
            
            
            Spacer()
        }
    }
}

struct BudgetView_Previews: PreviewProvider {
    static var previews: some View {
        
        BudgetView()
        
    }
}

