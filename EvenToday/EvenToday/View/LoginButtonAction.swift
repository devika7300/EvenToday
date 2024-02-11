//
//  LoginButtonAction.swift
//  EvenToday
//
//  Created by Devika Shendkar on 5/3/23.
//

import SwiftUI

struct LoginButtonAction: View {
    @EnvironmentObject var authViewModel:AuthViewModel
    
    
    var body: some View {
        NavigationView{
            
            VStack {
                Text("EvenToday")
                    .font(.custom("Georgia-Bold", size: 24))
                    .foregroundColor(Color(hex: "FF5C58"))
                //.frame(width: 145, height: 50)
                    .padding(.top, 280)
                //.position(x: 110, y: 210)
                
                VStack {
                    
                    
                    NavigationLink(destination: HostDashboard().environmentObject(authViewModel)) {
                        Text("View as Host")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .padding(.horizontal, 60)
                            .padding(.vertical, 12)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color(hex: "FF5151")))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(hex: "FFFFFF"), lineWidth: 1))
                    }
                    
                    NavigationLink(destination: AttedeeDashboard()) {
                        Text("View as Attendee")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .padding(.horizontal, 40)
                            .padding(.vertical, 12)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color(hex: "FF5151")))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(hex: "FFFFFF"), lineWidth: 1))
                    }
                }.padding(.top, 40)
                
                Spacer()
            }.background(Color.white.edgesIgnoringSafeArea(.all))
        }
    }
}


struct LoginButtonAction_Previews: PreviewProvider {
    static var previews: some View {
        LoginButtonAction()
    }
}
