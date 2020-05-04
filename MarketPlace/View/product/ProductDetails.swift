//
//  ProductDetails.swift
//  MarketPlace
//
//  Created by Ashish-Ritish on 3/4/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI
import FirebaseFirestore

struct ProductDetails: View {
    @Environment(\.presentationMode) var presentationMode
    @State var isFavorite = false
    @ObservedObject var product: Product
    @State private var showingSheet = false
    
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
    func markAsSold(){
        var id = ""
        getUsersId { usersId in
            
            if usersId.count > 0{
                while true {
                    id = usersId.randomElement()!
                    if id != uid!{
                        break
                    }
                }
                self.product.soldTo.append(id)
                productsCollectionRef.document(self.product.id).setData(self.product.data)
                CreateNotification(title: "Product sold", message: "\(self.product.name) has been sold", isPublic: true)
            }
            
        }
    }
    
    var actionSheet: ActionSheet{
        ActionSheet(title: Text(""), message: Text(product.name), buttons: [
            .default(Text("Mark as Sold"), action:{
                self.markAsSold()
            }),
            .destructive(Text("Delete"),
                         action: {
                            print("Deleted")
                            let id = self.product.id
                            productsCollectionRef.document(id).delete() { error in
                                if let error = error {
                                    print("Error removing document: \(error)")
                                } else {
                                    print("Document successfully removed")
                                    CreateNotification(title: "Product Deleted", message: "\(self.product.name) have been deleted", isPublic: true)
                               //     self.dismiss()
                                }
                            }
            }),
            .cancel()
        ])
    }
    
    func updateFavorite() {
        var favList:[String] = product.favoriteList
        
        if favList.contains(uid!){
            let index = favList.firstIndex(of: uid!)
            print(index!)
            favList.remove(at: index!)
            CreateNotification(title: "Favorite Remove", message: "You have remove favorite  of \(product.name)", isPublic: false)
        }else{
            favList.append(uid!)
            CreateNotification(title: "Favorite Added", message: "You have added favorite  of \(product.name)", isPublic: false)
        }
        
        productsCollectionRef.document(product.id).updateData([
            "favoriteList": favList
        ]) { err in
           if err != nil {
               print((err?.localizedDescription)!)
               return
           } else {
                print("successfully updated")
           }
        }
    }
    
    var body: some View {
        
        VStack(spacing : 0){
            if(self.product.imageUrls.count > 1){
                ProductImageView(self.product.imageUrls.map { ProductImage(picture: $0) })
            }else{
                ProductImage(picture: self.product.imageUrls[0])
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack (alignment: .leading, spacing: 10){
                    
                    HStack(spacing: 10){
                        
                        Text(product.name).font(.system(size: 25)).foregroundColor(Color("appBlue"))
                        Spacer()
                        if(product.addBy != uid! && product.soldTo.isEmpty) {
                            Button(action: {
                                self.isFavorite.toggle()
                                self.updateFavorite()
                            }){
                                if  product.favoriteList.contains(uid!) {
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(Color.red)
                                }else{
                                    Image(systemName: "heart")
                                        .foregroundColor(Color.gray)
                                }
                            }
                        }
                        
                    }
                    .padding([.leading,.trailing],10)
                    .padding(.bottom, 10)
                    
                    HStack(spacing: 10){
                        Image(systemName: "dollarsign.square")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(0)
                            .frame(height: 20)
                            .foregroundColor(Color("appBlue"))
                        
                        
                        Text(String(product.price)).fontWeight(.medium).font(.system(size: 20))
                        Spacer()
                    }
                    .padding([.leading,.trailing],10)
                    .padding(.bottom, 10)
                    
                    
                    HStack(spacing: 10){
                        Image(product.category)
                            .resizable()
                            .frame(width: 20, height: 20)
                        
                        Text(product.category).fontWeight(.medium).font(.system(size: 20))
                        Spacer()
                    }
                    .padding([.leading,.trailing],10)
                    .padding(.bottom, 10)
                    
                    
                    HStack(spacing: 10){
                        Image(systemName: "checkmark.shield")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(0)
                            .frame(height: 20)
                            .foregroundColor(Color("appBlue"))
                        Text(product.condition).fontWeight(.medium).font(.system(size: 20))
                        Spacer()
                    }
                    .padding([.leading,.trailing],10)
                    .padding(.bottom, 10)
                    
                    
                    HStack(spacing: 10){
                        Image(systemName: "envelope").foregroundColor(Color("appBlue"))
                        Text(product.email).fontWeight(.medium).font(.system(size: 20))
                        Spacer()
                    }
                    .padding([.leading,.trailing],10)
                    .padding(.bottom, 10)
                    
                    
                    HStack(alignment: .top, spacing: 10){
                        Image(systemName: "doc.text")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(0)
                            .frame(height: 20)
                            .foregroundColor(Color("appBlue"))
                        Text(product.description).fontWeight(.medium).font(.system(size: 20))
                        Spacer()
                    }
                    .padding([.leading,.trailing],10)
                    .padding(.bottom, 10)
                }
                .padding()
                
                MapView(location: [product.latitude, product.longitude])
                    .frame(height: 200)
            }
        }
        .navigationBarTitle(Text(product.name), displayMode: .inline)
            
        .navigationBarItems(trailing:
            HStack(spacing: 7){
                if product.addBy == uid! && product.soldTo.isEmpty {
                    NavigationLink(destination: EditProduct(product: product)){
                        HStack {
                            Image(systemName: "pencil").foregroundColor(Color.white)
                        }.padding(7)
                    }.background(((product.addBy == uid! && product.soldTo.isEmpty) ? Color("appBlue") : .gray).opacity(0.85))
                        .clipShape(Circle())
                    
                    Spacer()
                    
                    Button(action : {
                        self.showingSheet = true
                    }
                    ){
                        HStack {
                            Image(systemName: "ellipsis").foregroundColor(Color.white)
                        }.padding(7)
                    }.background(((product.addBy == uid! && product.soldTo.isEmpty) ? Color("appBlue") : .gray).opacity(0.85))
                        .clipShape(Circle())
                        .actionSheet(isPresented: self.$showingSheet, content: {
                            self.actionSheet })
                }
            }
        )
    }
    
}

var sampleProudct = Product(id: "1234", data: ["addBy": "8AbYDCOBe5QrGUVaYZk23YLmlvY2",
                                               "category": "Cell Phone",
                                               "condition": "New",
                                               "email": "rkark1@unh.newhaven.edu",
                                               "description": "Sample phone Data",
                                               "name": "Iphone8",
                                               "price": 622.00,
                                               "favoriteList": ["8AbYDCOBe5QrGUVaYZk23YLmlvY2"],
                                               "imageUrls": ["https://firebasestorage.googleapis.com/v0/b/marketplace-71120.appspot.com/o/Real%20State%2FGhar%2F00B0B_imKuvG07Bhf_600x450.jpg?alt=media&token=b8ef0d5c-dbea-4d71-a6a3-c25416792262",
                                               "https://firebasestorage.googleapis.com/v0/b/marketplace-71120.appspot.com/o/Real%20State%2FGhar%2F00m0m_7xa163K3Jyc_600x450.jpg?alt=media&token=2a8749ec-e810-4729-83f6-33faaebde207",
                                               "https://firebasestorage.googleapis.com/v0/b/marketplace-71120.appspot.com/o/Real%20State%2FGhar%2F00P0P_57FBcuR9IdY_600x450.jpg?alt=media&token=66afdb55-51f2-4ca7-9053-b906afab8f16"],
                                               "latitude": 41.26201,
                                               "longitude": -72.94621,
                                               "soldTo": ""
                                                ])

struct ProductDetails_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetails(product: sampleProudct!)
    }
}

