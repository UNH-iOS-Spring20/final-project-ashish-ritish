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
    @Published var products = [Product]()
    private let productsCollection = Firestore.firestore().collection("products")
        
    init() {
        listenForProductChanges()
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
                    
                    let name = diff.document.get("name") as! String
                    let price = diff.document.get("price") as! Double
                    let email = diff.document.get("email") as! String
                    let category = diff.document.get("category") as! String
                    let condition = diff.document.get("condition") as! String
                    let imageName = diff.document.get("imageName") as! String
                    let latitude = diff.document.get("latitude") as! Double
                    let longitude = diff.document.get("longitude") as! Double
                    let description = diff.document.get("description") as! String
                    let isFavorite = diff.document.get("isFavorite") as! Bool
                    let imageUrls = diff.document.get("imageUrls") as! Array<String>
                    
                    if name != nil || price != nil || email != nil || category != nil || imageUrls != nil {

                        let product = Product(id: diff.document.documentID,
                         name: name,
                         price: price,
                         email: email,
                         category: category,
                         condition: condition,
                         imageName: imageName,
                         latitude: latitude,
                         longitude: longitude,
                         description: description,
                         isFavorite: isFavorite,
                         imageUrls: imageUrls)
   
                        self.products.append(product)
                    }
                }
                
                // for new modifications the products value
                if (diff.type == .modified) {
                    print("product modified: \(diff.document.data())")
                    guard let modifiedIndex = self.products.firstIndex(where: { $0.id == diff.document.documentID }) else {
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
                    self.products[modifiedIndex].imageUrls =  diff.document.get("imageUrls") as! Array<String>
                }
                
                // for product items that are to be removed
                if (diff.type == .removed) {
                    print("product removed: \(diff.document.data())")
                    guard let removedIndex = self.products.firstIndex(where: { $0.id == diff.document.documentID }) else {
                        print("Could not find removed product in data model")
                        return
                    }
                    self.products.remove(at: removedIndex)
                }
            }
        }
    }
    
    // Adding product item
    func createProduct(name: String, price: Double, email: String, category: String, condition: String, imageName: String, latitude: Double, longitude: Double, description: String, isFavorite: Bool, imageUrls: Array<String>) {
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
            "isFavorite": isFavorite,
            "imageUrls": imageUrls
        ])
    }
    
    // deleting product item
    func deleteProduct(index: Int) {
        print("Deleting product: \(products[index])")
        let id = self.products[index].id
        productsCollection.document(id).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
}
