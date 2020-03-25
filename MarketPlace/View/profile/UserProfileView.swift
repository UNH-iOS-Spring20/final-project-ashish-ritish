//
//  UserProfileView.swift
//  MarketPlace
//
//  Created by ritish karki on 3/20/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI

struct UserProfileView: View {
    // MARK: - Propertiers
    @State private var email = ""
    @State private var password = ""
    @State private var userRating = 4
    var body: some View {
        VStack{
            VStack{
                GeometryReader { geometry in
                    HStack{
                        Image("karki")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .edgesIgnoringSafeArea(.top)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .shadow(radius: 10)
                        .edgesIgnoringSafeArea(.top)
                        .scaledToFit()
                        .padding([.top,.bottom], 50)
                        .padding([.leading,.trailing], 20)
                        
                        VStack(alignment: .leading){
                            Text("Ritish Karki").font(.system(size: 25))
                            Text("21 Andrews Street, West Haven")
                            Section {
                                RatingView(rating: self.$userRating)
                            }
                        }
                    }
                    .frame(width: geometry.size.width)
                }
                
                HStack{
                    NavigationLink(destination: NotificationView()){
                        VStack{
                            Image(systemName: "bell.fill")
                            Text("Notification")
                                .multilineTextAlignment(.leading)
                        }
                    }
                    NavigationLink(destination: ListScreenView()){
                        VStack{
                            Image(systemName: "list.dash")
                            Text("List")
                        }
                    }
                }
            }
            .background(Color(UIColor(red:0, green: 0, blue: 0, alpha: 0.05)))
            .frame(height:200)
           Spacer()
            
           HStack(spacing: 0) {
               Button(action: {}) {
                   Text("Log Out")
                       .foregroundColor(.black)
               }
           }
       }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}

extension Color {
    static var themeTextField: Color {
        return Color(red: 220.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, opacity: 1.0)
    }
}