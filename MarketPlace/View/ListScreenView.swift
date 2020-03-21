//
//  ListView.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 3/19/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI

struct ListScreenView: View {
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
            ListScreenView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("List")
            }
        }.edgesIgnoringSafeArea(.top)
        .padding(.top, 0)
    }
}

struct ListScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ListScreenView()
    }
}
