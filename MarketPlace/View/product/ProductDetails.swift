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
        VStack{
            ProductImageView(self.product.imageUrls.map { ProductImage(picture: $0) })//.frame(height: 250)
                .aspectRatio(contentMode: .fit)
            VStack (alignment: .leading){
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
                }
                
                HStack{
                    Text("Name:")
                        .font(.headline)
                        .padding(.leading, 25)
                    Spacer()
                    Text(product.name)
                        .font(.headline)
                }
                .padding(10)
                HStack{
                    Text("Category:")
                        .font(.headline)
                        .padding(.leading,25)
                    Spacer()
                    Text(product.category)
                        .font(.headline)
                    
                }.padding(10)
                HStack{
                    Text("Condition:")
                        .font(.headline)
                        .padding(.leading,25)
                    Spacer()
                    Text(product.condition)
                        .font(.headline)
                    
                }
                .padding(10)
                HStack{
                    Text("Email")
                        .font(.headline)
                        .padding(.leading, 25)
                    Spacer()
                    Text(product.email)
                        .font(.headline)
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
                .frame(height: 200)
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



