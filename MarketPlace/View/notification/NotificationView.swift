//
//  NotificationView.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 3/19/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI

struct NotificationView: View {
    @State private var showingSheet = false
    @State private var actionTitle = ""
    @State private var notificationId = ""
    
    @ObservedObject private var session = firebaseSession
    
    var actionSheet: ActionSheet{
        ActionSheet(title: Text(""), message: Text(actionTitle), buttons: [
            .destructive(Text("Delete"), action: {
                print("Delete")
                self.session.deletenotification(id: self.notificationId)
            }),
            .cancel(Text("Cancel"), action:{
                self.actionTitle = ""
                self.notificationId = ""
            })
        ])
    }
    
    var body: some View {
        List{
            ForEach(session.notifications, id: \.self.id) { notification in
                HStack(){
                    Image("AppLogo")
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color.white, lineWidth: 2))
                        .shadow(radius: 4)
                        .scaledToFit()
                    HStack() {
                        VStack(alignment: .leading) {
                            Text(notification.title)
                                .font(.headline)
                                .foregroundColor(.primary)
                                .fixedSize(horizontal: false, vertical: true)
                                .layoutPriority(98)
                            Text(notification.description)
                                .font(.headline)
                                .foregroundColor(.secondary)
                                .fixedSize(horizontal: false, vertical: true)
                                .layoutPriority(99)
                        }
                        .padding(10)
                        Spacer()
                        Button(action : {
                            self.showingSheet = true
                            self.notificationId = notification.id
                            self.actionTitle = notification.title
                        }){
                            Image(systemName: "ellipsis")
                        }
                        .actionSheet(isPresented: self.$showingSheet, content: {
                            self.actionSheet })
                        
                    }
                    
                }
                .padding(10)
            }
        }
        .navigationBarTitle(Text("Notifications"), displayMode: .inline)
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
