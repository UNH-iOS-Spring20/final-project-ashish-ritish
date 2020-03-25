//
//  FirebaseSession.swift
//  MarketPlace
//
//  Created by ritish karki on 3/17/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import FirebaseFirestore

let firebaseSession = FirebaseSession() // singleton

class FirebaseSession: ObservableObject {
    @Published var categories = [Category]()
    @Published var products = [Product]()
    @Published var notifications = [Notification]()
    
    private let categoriesCollection = Firestore.firestore().collection("categories")
    private let productsCollection = Firestore.firestore().collection("products")
    private let notificationsCollection = Firestore.firestore().collection("notifications")
        
    init() {
        listenForCategoryChanges()
        listenForProductChanges()
        listenForNotificationChanges()
    }
    
    // Reference link : https://firebase.google.com/docs/firestore/query-data/listen
    func listenForCategoryChanges() {
        categoriesCollection.addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            
            snapshot.documentChanges.forEach { diff in
                if (diff.type == .added) {
                    print("category added: \(diff.document.data())")
                    let category = Category(id: diff.document.documentID,
                                            name: diff.document.get("name") as! String)
                    self.categories.append(category)
                }
                if (diff.type == .modified) {
                    print("category modified: \(diff.document.data())")
                    guard let modifiedIndex = self.categories.firstIndex(where: { $0.id == diff.document.documentID }) else {
                        print("Could not find modified category in data model")
                        return
                    }
                    self.categories[modifiedIndex].name = diff.document.get("name") as! String
                }
                if (diff.type == .removed) {
                    print("category removed: \(diff.document.data())")
                    guard let removedIndex = self.categories.firstIndex(where: { $0.id == diff.document.documentID }) else {
                        print("Could not find removed category in data model")
                        return
                    }
                    self.categories.remove(at: removedIndex)
                }
            }
        }
    }
    
    // Reference link: https://firebase.google.com/docs/firestore/manage-data/add-data
    func createcategory(name: String, city: String, state: String) {
        categoriesCollection.document().setData([
            "name": name
        ])
    }
    
    // Reference link: https://firebase.google.com/docs/firestore/manage-data/delete-data
    func deletecategory(index: Int) {
        print("Deleting category: \(categories[index])")
        let id = self.categories[index].id
        categoriesCollection.document(id).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    // listening for changes in product addition or just reading the products
    func listenForProductChanges(){
        productsCollection.addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            
            snapshot.documentChanges.forEach { diff in
                // for new add and read
                if (diff.type == .added) {
                    print("product added: \(diff.document.data())")
                    let product = Product(id: diff.document.documentID,
                                          name: diff.document.get("name") as! String,
                                          price: diff.document.get("price") as! Double,
                                          email: diff.document.get("email") as! String,
                                          category: diff.document.get("category") as! String,
                                          condition: diff.document.get("condition") as! String,
                                          imageName: diff.document.get("imageName") as! String,
                                          latitude: diff.document.get("latitude") as! Double,
                                          longitude: diff.document.get("longitude") as! Double,
                                          description: diff.document.get("description") as! String,
                                          isFavorite: diff.document.get("isFavorite") as! Bool)
                    
                    self.products.append(product)
                }
                
                // for new modifications the products value
                if (diff.type == .modified) {
                    print("product modified: \(diff.document.data())")
                    guard let modifiedIndex = self.categories.firstIndex(where: { $0.id == diff.document.documentID }) else {
                        print("Could not find modified product in data model")
                        return
                    }
                    
                    self.products[modifiedIndex].name = diff.document.get("name") as! String
                    self.products[modifiedIndex].price = diff.document.get("price") as! Double
                    self.products[modifiedIndex].email = diff.document.get("email") as! String
                    self.products[modifiedIndex].category = diff.document.get("category") as! String
                    self.products[modifiedIndex].condition = diff.document.get("condition") as! String
                    self.products[modifiedIndex].imageName = diff.document.get("imageName") as! String
                    self.products[modifiedIndex].latitude = diff.document.get("latitude") as! Double
                    self.products[modifiedIndex].longitude = diff.document.get("longitude") as! Double
                    self.products[modifiedIndex].description = diff.document.get("description") as! String
                    self.products[modifiedIndex].isFavorite = diff.document.get("isFavorite") as! Bool
                }
                
                // for product items that are to be removed
                if (diff.type == .removed) {
                    print("product removed: \(diff.document.data())")
                    guard let removedIndex = self.categories.firstIndex(where: { $0.id == diff.document.documentID }) else {
                        print("Could not find removed product in data model")
                        return
                    }
                    self.products.remove(at: removedIndex)
                }
            }
        }
    }
    
    // Adding product item
    func createProduct(name: String, price: Double, email: String, category: String, condition: String, imageName: String, latitude: Double, longitude: Double, description: String, isFavorite: Bool) {
        productsCollection.document().setData([
            "name": name,
            "price": price,
            "email": email,
            "category": category,
            "condition": condition,
            "imageName": imageName,
            "latitude": latitude,
            "longitude": longitude,
            "description": description,
            "isFavorite": isFavorite
        ])
    }
    
    // deleting product item
    func deleteProduct(index: Int) {
        print("Deleting product: \(categories[index])")
        let id = self.categories[index].id
        productsCollection.document(id).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    // listening for notifications changes
    func listenForNotificationChanges() {
        notificationsCollection.addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            
            snapshot.documentChanges.forEach { diff in
                if (diff.type == .added) {
                    print("notification added: \(diff.document.data())")
                    let title = diff.document.get("title") as? String
                    let description = diff.document.get("description") as? String
                    let createdTime = diff.document.get("createdTime") as? Int
                    let seenTime = diff.document.get("seenTime") as? Int
                    
                    if title != nil || description != nil || createdTime != nil {
                        let notification = Notification(id: diff.document.documentID,
                                                title: title ?? "",
                                                description: description ?? "",
                                                createdTime:createdTime ?? 0,
                                                seenTime: seenTime ?? 0
                                            )
                        self.notifications.append(notification)
                    }
                    
                }
                if (diff.type == .modified) {
                    print("notification modified: \(diff.document.data())")
                    guard let modifiedIndex = self.notifications.firstIndex(where: { $0.id == diff.document.documentID }) else {
                        print("Could not find modified notification in data model")
                        return
                    }
                    self.notifications[modifiedIndex].title = diff.document.get("title") as! String
                }
                if (diff.type == .removed) {
                    print("notification removed: \(diff.document.data())")
                    guard let removedIndex = self.notifications.firstIndex(where: { $0.id == diff.document.documentID }) else {
                        print("Could not find removed notification in data model")
                        return
                    }
                    self.notifications.remove(at: removedIndex)
                }
            }
        }
    }
    
    //adding notification item
    func createnotification(title: String, description: String, createdTime: Int, seenTime: Int) {
       notificationsCollection.document().setData([
           "title": title,
           "description": description,
           "createdTime": createdTime,
           "seenTime": seenTime
       ])
   }
    
    func deletenotification(id: String) {
        print("Deleting notification")
        notificationsCollection.document(id).delete() { err in
            if let err = err {
                print("Error removing notification: \(err)")
            } else {
                print("notification successfully removed!")
            }
        }
    }
}




