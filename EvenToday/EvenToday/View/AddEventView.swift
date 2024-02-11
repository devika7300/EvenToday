//
//  AddEventView.swift
//  EvenToday
//
//  Created by Devika Shendkar on 5/4/23.
//

import SwiftUI

struct AddEventView: View {
    @State private var isShowingBirthdayView = false
        @State private var isShowingMarriageView = false
        @State private var isShowingCulturalView = false
        
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Text("Choose Your Event")
                .font(.system(size: 30, weight: .bold, design: .default))
                .foregroundColor(Color(hex: "FF5C58"))
                .padding(.horizontal)
                .padding(.top, 50)
            Spacer()
            VStack(spacing: 20) {
                Button(action: {
                                    isShowingBirthdayView = true
                                }) {
                                    Image("birthday-cake")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                }
                                .buttonStyle(CircleButtonStyle(label: "Birthday"))
                                .sheet(isPresented: $isShowingBirthdayView) {
                                    BirthdayEventView()
                                }
                                
                                Button(action: {
                                    isShowingMarriageView = true
                                }) {
                                    Image("wedding")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                }
                                .buttonStyle(CircleButtonStyle(label: "Marriage"))
                                .sheet(isPresented: $isShowingMarriageView) {
                                    MarriageEventView()
                                }
                                
                                Button(action: {
                                    isShowingCulturalView = true
                                }) {
                                    Image("celeb")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                }
                                .buttonStyle(CircleButtonStyle(label: "Cultural"))
                                .sheet(isPresented: $isShowingCulturalView) {
                                    CulturalEventView()
                                }
                            }
            .padding(.bottom, 50)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "FFE6E6"))
    }
}


struct AddEventView_Previews: PreviewProvider {
    static var previews: some View {
        AddEventView()
    }
}
