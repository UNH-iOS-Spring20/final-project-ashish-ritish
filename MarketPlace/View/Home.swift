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
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
            }
            NotificationView()
                .tabItem {
                    Image(systemName: "bell.fill")
                    Text("Notification")
            }
            SellView()
                .tabItem {
                    Image(systemName: "camera.fill")
                    Text("Sell")
            }
            ListView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("List")
            }
        }.font(.headline)
    }
    
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}