//
//  NotificationView.swift
//  MarketPlace
//
//  Created by Ashish-Ritish on 3/19/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI
import FirebaseFirestore

let notificationsCollectionRef = Firestore.firestore().collection("notifications")

struct NotificationView: View {
    @State private var showingSheet = false
    @State private var actionTitle = ""
    @State private var notificationId = ""
    @ObservedObject private var notifications = FirebaseCollection<Notification>(collectionRef: notificationsCollectionRef)
    
    var actionSheet: ActionSheet{
        ActionSheet(title: Text(""), message: Text(actionTitle), buttons: [
            .destructive(Text("Delete"), action: {
                let id = self.notificationId
                notificationsCollectionRef.document(id).delete() { error in
                    if let error = error {
                        print("Error removing document: \(error)")
                    } else {
                        print("Document successfully removed")
                    }
                }
            }),
            .cancel(Text("Cancel"), action:{
                self.actionTitle = ""
                self.notificationId = ""
            })
        ])
    }
    
    var body: some View {
        NavigationView{
            List{
                ForEach(notifications.items, id: \.self.id) { notification in
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
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
