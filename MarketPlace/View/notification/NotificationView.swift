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
    @ObservedObject private var notifications = FirebaseCollection<Notification>(collectionRef: notificationsCollectionRef)
  //  @ObservedObject private var products = FirebaseCollection<Product>(collectionRef: productsCollectionRef)
    
    func deleteNotification(at offsets: IndexSet) {
        var count = 0
        let index = offsets.first!
        var id = ""
         let filteredList = notifications.items.sorted(by: {$0.createdTime > $1.createdTime }).filter{($0.isPublic && !$0.clearId.contains(uid!)) || (!$0.isPublic && $0.userId == uid!)}
        for items in filteredList{
            if count == index{
                id = items.id
            }
            count+=1
        }
        
        var notificationIndex = 0
        for (i, not) in notifications.items.enumerated(){
            if id == not.id{
                notificationIndex = i
                break
            }
        }
    
       
        if notifications.items[notificationIndex].isPublic {
            notifications.items[notificationIndex].clearId.append(uid!)
            notificationsCollectionRef.document(id).setData(notifications.items[notificationIndex].data)
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
        let filteredList = notifications.items.sorted(by: {$0.createdTime > $1.createdTime }).filter{($0.isPublic && !$0.clearId.contains(uid!)) || (!$0.isPublic && $0.userId == uid!)}
       // print(filteredList)
        return NavigationView{
            List{
                if filteredList.count > 0 {
                ForEach(filteredList, id: \.self.id) { notification in
                    HStack(spacing: 20){
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
                            VStack(alignment: .leading, spacing: 3) {
                                Text(notification.title)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .layoutPriority(98)
                                    .padding(.bottom, 3)
                                Text(notification.description)
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .layoutPriority(99)
                                HStack(){
                                    Image(systemName: "timer")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 12)
                                        .foregroundColor(.gray)
                                    Text(Date(timeIntervalSince1970: TimeInterval(notification.createdTime)).timeAgo() + " ago")
                                        .font(.system(size: 12))
                                        .foregroundColor(.gray)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .layoutPriority(99)
                                    
                                }
                            }
                    }
                }.onDelete{ index in
                    self.deleteNotification(at: index)
                }
                 .padding(.top, 5)
                }else {
                    HStack {
                        Spacer()
                        Text("No any notificationss")
                        Spacer()
                    }
                }
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
