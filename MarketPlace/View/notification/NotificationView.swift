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
    
    
    func deleteNotification(at offsets: IndexSet) {
        let index = offsets.first!
        let id = notifications.items[index].id
        notifications.items[index].userId.append(uid!)
        notificationsCollectionRef.document(id).setData(notifications.items[index].data)
    }
    
    var body: some View {
        NavigationView{
            List{
                ForEach(notifications.items.filter{ !$0.userId.contains(uid!)}, id: \.self.id) { notification in
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
                            
                        }
                        
                    }
                    .padding(10)
                }.onDelete(perform: deleteNotification)
            }
            .navigationBarTitle(Text("Notifications"), displayMode: .inline)
            .navigationBarItems(leading: EditButton())
        }
        
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
