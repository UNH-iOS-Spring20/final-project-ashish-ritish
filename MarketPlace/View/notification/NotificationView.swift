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
    @ObservedObject private var products = FirebaseCollection<Product>(collectionRef: productsCollectionRef)
    
    
    func deleteNotification(at offsets: IndexSet) {
        let index = offsets.first!
        let id = notifications.items[index].id
        if notifications.items[index].isPublic {
            notifications.items[index].clearId.append(uid!)
            notificationsCollectionRef.document(id).setData(notifications.items[index].data)
        } else{
            notificationsCollectionRef.document(id).delete() { err in
                if let err = err {
                    print("Error removing dpcument: \(err)")
                }else{
                    print("Document successfully removed!")
                }
                
            }
        }
    }
    
    var body: some View {
        NavigationView{
            List{
                ForEach(notifications.items.filter{($0.isPublic && !$0.clearId.contains(uid!)) || (!$0.isPublic && $0.userId == uid!)}, id: \.self.id) { notification in
                    HStack(){
                        Image("AppLogo")
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: 50, height: 50)
                            .edgesIgnoringSafeArea(.top)
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(Color.white, lineWidth: 2))
                            .shadow(radius: 5)
                            .edgesIgnoringSafeArea(.top)
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

func CreateNotification( title: String, message: String, isPublic: Bool){
    let now = Int(NSDate().timeIntervalSince1970)
    
    let content = UNMutableNotificationContent()
    content.title = title
    content.subtitle = message
    content.sound = UNNotificationSound.default
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
    
    let req = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().add(req, withCompletionHandler: nil)
    
    var notificationData = [String:Any]()
    notificationData["createdTime"] = now
    notificationData["title"] = title
    notificationData["description"] = message
    notificationData["seenTime"] = now
    notificationData["clearId"] = []
    notificationData["isPublic"] = isPublic
    notificationData["userId"] = uid!
    
    notificationsCollectionRef.addDocument(data: notificationData)
    
}
