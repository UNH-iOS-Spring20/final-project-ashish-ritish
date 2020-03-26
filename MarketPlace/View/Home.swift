//
//  Home.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 3/3/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI
import FirebaseFirestore

struct Home: View {
    init() {
          UINavigationBar.appearance().titleTextAttributes = [
             .foregroundColor: UIColor.darkGray,
            .font : UIFont(name: "Arial", size: 20)!]
    }
  
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
            }
            NavigationView{
            NotificationView()
            }
                .tabItem {
                    Image(systemName: "bell.fill")
                    Text("Notification")
            }
            NavigationView{
            SellView()
            }
                .tabItem {
                    Image(systemName: "camera.fill")
                    Text("Sell")
            }
            NavigationView{
                ListScreenView()
            }
            .tabItem {
                Image(systemName: "list.dash")
                Text("List")
            
            }
        }
    }
    
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
