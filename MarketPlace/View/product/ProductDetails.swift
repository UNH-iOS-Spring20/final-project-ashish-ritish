//
//  ProductDetails.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 3/4/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI

struct ProductDetails: View {
    @ObservedObject var product: Product
    
    func updateFavorite() {
        if !product.name.isEmpty && !product.category.isEmpty && !product.condition.isEmpty && !product.description.isEmpty &&
            !product.email.isEmpty && !product.imageUrls.isEmpty && !product.imageName.isEmpty && !String(product.isFavorite).isEmpty && !String(product.latitude).isEmpty && !String(product.longitude).isEmpty && !String(product.price).isEmpty {
            
            productsCollectionRef.document(self.product.id).setData(self.product.data)
            print(self.product.data)
        }
        else{
            print("Cannot update Sorry")
        }
    }
    
    var body: some View {
        VStack(spacing : 0){
            ProductImageView(self.product.imageUrls.map { ProductImage(picture: $0, setHeight: false) })
            HStack{
                Spacer()
                Button(action: {
                    self.product.isFavorite.toggle()
                    self.updateFavorite()
                }){
                    if  product.isFavorite {
                        Image(systemName: "heart.fill")
                            .foregroundColor(Color.red)
                    }else{
                        Image(systemName: "heart")
                            .foregroundColor(Color.gray)
                    }
                }
            }.padding(20)
            VStack (spacing: 15){
                
                
                HStack{
                    Text("Name:")
                        .font(.headline)
                        .padding(.leading, 25)
                    Spacer()
                    Text(product.name)
                        .font(.headline)
                }
        
                HStack{
                    Text("Category:")
                        .font(.headline)
                        .padding(.leading,25)
                    Spacer()
                    Text(product.category)
                        .font(.headline)
                    
                }
              
                HStack{
                    Text("Condition:")
                        .font(.headline)
                        .padding(.leading,25)
                    Spacer()
                    Text(product.condition)
                        .font(.headline)
                    
                }
            
                HStack{
                    Text("Email")
                        .font(.headline)
                        .padding(.leading, 25)
                    Spacer()
                    Text(product.email)
                        .font(.headline)
                }
            
                HStack{
                    Text("Price:")
                        .font(.headline)
                        .padding(.leading, 25)
                    Spacer()
                    Text("$ " + String(product.price))
                        .font(.headline)
                        .padding(.leading,50)
                }
            }
            .padding()
            
            MapView(location: [product.latitude, product.longitude])
                .frame(height: 160)
        }
        .navigationBarTitle(Text(product.name), displayMode: .inline)
    }
}

var sampleProudct = Product(id: "1234", data: [ "name": "Iphone8", "price": 622.00, "email": "rkark1@unh.newhaven.edu", "category": "Cell Phone", "condition": "New", "imageName": "Ihone8", "latitude": 41.26201, "longitude": -72.94621, "description": "Sample phone Data", "isFavorite": true, "imageUrls": ["https://firebasestorage.googleapis.com/v0/b/marketplace-71120.appspot.com/o/Real%20State%2FGhar%2F00B0B_imKuvG07Bhf_600x450.jpg?alt=media&token=b8ef0d5c-dbea-4d71-a6a3-c25416792262",
                                                                                                                                                                                                                                                                                                                 "https://firebasestorage.googleapis.com/v0/b/marketplace-71120.appspot.com/o/Real%20State%2FGhar%2F00m0m_7xa163K3Jyc_600x450.jpg?alt=media&token=2a8749ec-e810-4729-83f6-33faaebde207",
                                                                                                                                                                                                                                                                                                                 "https://firebasestorage.googleapis.com/v0/b/marketplace-71120.appspot.com/o/Real%20State%2FGhar%2F00P0P_57FBcuR9IdY_600x450.jpg?alt=media&token=66afdb55-51f2-4ca7-9053-b906afab8f16"]])

struct ProductDetails_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetails(product: sampleProudct!)
    }
}



