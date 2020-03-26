//
//  ProductDetails.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 3/4/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI

struct ProductDetails: View {
    var product: Product
    
    var body: some View {
       // ScrollView(.vertical, showsIndicators: false) {
        VStack{
            ProductImage(picture: product.imageName)
            VStack (alignment: .leading){
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
     //    }
    }
}

struct ProductDetails_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetails(product: firebaseSession.products[0])
    }
}
