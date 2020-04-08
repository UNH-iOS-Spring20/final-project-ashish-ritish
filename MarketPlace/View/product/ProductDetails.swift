//
//  ProductDetails.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 3/4/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI

struct ProductDetails: View {
    @EnvironmentObject var userData: UserData
    var product: Product
    
    var productIndex: Int {
        userData.products.items.firstIndex(where: { $0.id == product.id })!
    }
        
    
    var body: some View {
        // ScrollView(.vertical, showsIndicators: false) {
        VStack{
            ProductImageView(self.product.imageUrls.map { ProductImage(picture: $0) }).frame(height: 250)
            VStack (alignment: .leading){
                HStack{
                    Spacer()

                    Button(action: {
                        
                    }){
                        if self.userData.products.items[self.productIndex].isFavorite {
                            Image(systemName: "heart.fill")
                                .imageScale(.medium)
                                .foregroundColor(.red)
                        }else{
                            Image(systemName: "heart")
                                .imageScale(.medium)
                                .foregroundColor(.gray)

                        }

                    }
                }
                
                HStack{
                    Text("Name:")
                        .font(.headline)
                        .padding(.leading, 25)
                    Spacer()
                    Text(product.name)
                        .font(.headline)
                    //     .padding(.trailing, 50)
                }
                .padding(10)
                HStack{
                    Text("Category:")
                        .font(.headline)
                        .padding(.leading,25)
                    Spacer()
                    Text(product.category)
                        .font(.headline)
                    //   .padding(.trailing, 50)
                    
                }.padding(10)
                HStack{
                    Text("Condition:")
                        .font(.headline)
                        .padding(.leading,25)
                    Spacer()
                    Text(product.condition)
                        .font(.headline)
                    //   .padding(.trailing, 50)
                    
                }
                .padding(10)
                HStack{
                    Text("Email")
                        .font(.headline)
                        .padding(.leading, 25)
                    Spacer()
                    Text(product.email)
                        .font(.headline)
                    //    .padding(.leading,50)
                }
                .padding(10)
                HStack{
                    Text("Price:")
                        .font(.headline)
                        .padding(.leading, 25)
                    Spacer()
                    Text("$ " + String(product.price))
                        .font(.headline)
                        .padding(.leading,50)
                }
                .padding(10)
                
                
            }
            .padding()
            
            MapView(location: [product.latitude, product.longitude])
                .frame(height: 250)
        }
        .navigationBarTitle(Text(product.name), displayMode: .inline)
        .padding(.top, 10)
    }
}

var sampleProudct = Product(id: "1234", data: [ "name": "Iphone8", "price": 622.00, "email": "rkark1@unh.newhaven.edu", "category": "Cell Phone", "condition": "New", "imageName": "Ihone8", "latitude": 41.26201, "longitude": -72.94621, "description": "Sample phone Data", "isFavorite": true, "imageUrls": ["https://cdn.pixabay.com/photo/2016/02/13/13/11/cuba-1197800_1280.jpg","https://firebasestorage.googleapis.com/v0/b/marketplace-71120.appspot.com/o/BMW.png?alt=media&token=aca57096-47ee-46d9-86e2-f81c81cb0c14","https://cdn.pixabay.com/photo/2016/02/13/13/11/cuba-1197800_1280.jpg"]])

struct ProductDetails_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetails(product: sampleProudct!)
    }
}



