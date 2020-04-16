//
//  Account.swift
//  MarketPlace
//
//  Created by ritish karki on 4/15/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//
import Firebase
import SwiftUI

func CreateUser(name: String,about : String,imagedata : Data, zipCode: String, phoneNumber: String, location: String, completion : @escaping (Bool)-> Void){
    
    let db = Firestore.firestore()
    
    let storage = Storage.storage().reference()
    
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
                
                completion(true)
                
                UserDefaults.standard.set(true, forKey: "status")
                
                UserDefaults.standard.set(name, forKey: "UserName")
                
                NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
            }
        }
    }
}

func checkUser(completion: @escaping (Bool,String)->Void){
    
    let db = Firestore.firestore()
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
                
               

                let currentUser = UserProfile(id: id, data: ["name": name, "email": email, "phoneNumber": phoneNumber, "zipcode": zipCode, "address": address, "about": about, "photoUrl": photoUrl])
                            
                UserDefaults.standard.set(currentUser, forKey: "currentUser")
                
                completion(true,i.get("name") as! String)
                return
            }
        }

        completion(false,"")
    }
    
}
