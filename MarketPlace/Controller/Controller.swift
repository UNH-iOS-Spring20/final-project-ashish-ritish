//
//  Account.swift
//  MarketPlace
//
//  Created by Ashish-Ritish on 4/15/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//
import Firebase
import Foundation

let db = Firestore.firestore()
let storage = Storage.storage().reference()

func CreateUser(name: String,about : String,imagedata : Data, zipCode: String, phoneNumber: String, location: String, completion : @escaping (Bool, String)-> Void){
    
    
    let uid = Auth.auth().currentUser?.uid
    let email = Auth.auth().currentUser?.email
    
    storage.child("profilepics").child(uid!).putData(imagedata, metadata: nil) { (_, err) in
        
        if err != nil{
            
            print((err?.localizedDescription)!)
            return
        }
        
        storage.child("profilepics").child(uid!).downloadURL { (url, err) in
            
            if err != nil{
                
                print((err?.localizedDescription)!)
                return
            }
            
            db.collection("users").document(uid!).setData(["name":name,"email":email!, "about":about,"photoUrl":"\(url!)","id":uid!, "zipCode":zipCode, "phoneNumber": phoneNumber, "address": location]) { (err) in
                
                if err != nil{
                    
                    print((err?.localizedDescription)!)
                    return
                }
                
                completion(true, url!.path)
                
                UserDefaults.standard.set(true, forKey: "status")
                UserDefaults.standard.set(name, forKey: "UserName")
                checkForNewUserExistence()
                NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                UserDefaults.standard.synchronize()
            }
        }
    }
}

func getUsersId(completion: @escaping ([String])->Void){
    let db = Firestore.firestore()
    var usersId: [String] = []
    db.collection("users").getDocuments { (snap, err) in

        if err != nil{
            print((err?.localizedDescription)!)
            return
        }
        
        for i in snap!.documents{
            usersId.append(i.documentID)
        }
        
        completion(usersId)
    }
}

func checkUser(completion: @escaping (Bool,String)->Void){
    db.collection("users").getDocuments { (snap, err) in

        if err != nil{

            print((err?.localizedDescription)!)
            return
        }

        for i in snap!.documents{

            if i.documentID == Auth.auth().currentUser?.uid{
                
                let id = i.data()["id"] as! String
                let name = i.data()["name"] as! String
                let email = i.data()["email"] as! String
                let phoneNumber = i.data()["phoneNumber"] as! String
                let zipCode = i.data()["zipCode"] as! String
                let address = i.data()["address"] as! String
                let about = i.data()["about"] as! String
                let photoUrl = i.data()["photoUrl"] as! String
                
                
                Defaults.save(name: name, address: address, id: id, zipCode: zipCode, phoneNumber: phoneNumber, email: email, photoUrl: photoUrl, about: about)
                
                UserDefaults.standard.set(false, forKey: "NewUser")
                completion(true,i.get("name") as! String)
                return
            }
        }

        completion(false,"")
    }
    
}

func addProduct(name: String,price : String,images : [UIImage], category: String, condition: String, latitude: Double, longitude: Double, description: String, completion : @escaping (Bool)-> Void){
    
    print("latitude \(latitude)")
    print("longitude \(longitude)")
    let favoriteList:[String] = []

    let uid = Auth.auth().currentUser?.uid
    var productUrls: [String] = []
    
    for (index, image) in images.enumerated() {
        
        let parentDirectory = category
        let documentIdentifier = uid! + name + randomString(length: 8)
        let finalDocumentId = documentIdentifier.filter { !$0.isNewline && !$0.isWhitespace }
        
        let currentImage = image.resizeWithWidth(width: 500)!
        let imageData = currentImage.jpegData(compressionQuality: 1)!
        
        storage.child(parentDirectory).child(finalDocumentId).putData(imageData, metadata: nil) { (_, err) in

            if err != nil{

                print((err?.localizedDescription)!)
                return
            }

            storage.child(parentDirectory).child(finalDocumentId).downloadURL { (url, err) in

                if err != nil{

                    print((err?.localizedDescription)!)
                    return
                }
                
                productUrls.append("\(url!)")

                if index == images.count - 1 {
                    
                    var productData = [String:Any]()
                    productData["name"] = name
                    productData["price"] = Double(price)
                    productData["category"] = category
                    productData["condition"] = condition
                    productData["longitude"] = longitude
                    productData["latitude"] = latitude
                    productData["imageUrls"] = productUrls
                    productData["description"] = description
                    productData["soldTo"] = ""
                    productData["addBy"] = uid!
                    productData["favoriteList"] = favoriteList
                    productData["email"] = Defaults.getUserDetails().email
                    
                    productsCollectionRef.addDocument(data: productData){ err in
                        if err != nil {
                            print((err?.localizedDescription)!)
                            completion(false)
                            return
                        }
                        
                        completion(true)
                    }
                }
                
            }
        }
        
    }
}

func modifyProduct(name: String,price : String,images : [UIImage], category: String, condition: String, description: String, completion : @escaping (Bool)-> Void){
    
    let uid = Auth.auth().currentUser?.uid
    var productUrls: [String] = []
    
    for (index, image) in images.enumerated() {
        
        let parentDirectory = category
        let documentIdentifier = uid! + name + randomString(length: 8)
        let finalDocumentId = documentIdentifier.filter { !$0.isNewline && !$0.isWhitespace }
        
        let currentImage = image.resizeWithWidth(width: 500)!
        let imageData = currentImage.jpegData(compressionQuality: 1)!
        
        storage.child(parentDirectory).child(finalDocumentId).putData(imageData, metadata: nil) { (_, err) in

            if err != nil{

                print((err?.localizedDescription)!)
                return
            }

            storage.child(parentDirectory).child(finalDocumentId).downloadURL { (url, err) in

                if err != nil{

                    print((err?.localizedDescription)!)
                    return
                }
                
                productUrls.append("\(url!)")

                if index == images.count - 1 {
                    
                    var productData = [String:Any]()
                    productData["name"] = name
                    productData["price"] = Double(price)
                    productData["category"] = category
                    productData["condition"] = condition
                    productData["imageUrls"] = productUrls
                    productData["description"] = description
                    productData["addBy"] = uid!
                    
                    productsCollectionRef.addDocument(data: productData){ err in
                        if err != nil {
                            print((err?.localizedDescription)!)
                            completion(false)
                            return
                        }
                        
                        completion(true)
                    }
                }
                
            }
        }
        
    }
}


func randomString(length: Int) -> String {
  let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  return String((0..<length).map{ _ in letters.randomElement()! })
}
