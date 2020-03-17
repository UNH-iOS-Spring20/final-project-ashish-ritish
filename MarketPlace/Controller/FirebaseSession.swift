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
    private let categoriesCollection = Firestore.firestore().collection("categories")
        
    init() {
        listenForChanges()
        
    }
    
    // Reference link : https://firebase.google.com/docs/firestore/query-data/listen
    func listenForChanges() {
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
}
