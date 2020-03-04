//
//  ProductDetails.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 3/4/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI

struct ProductDetails: View {
    var body: some View {
        VStack{
            
            CategoryImage()
               // .frame(height: 300)
               // .edgesIgnoringSafeArea(.top)
            
            VStack (alignment: .leading){
                Text("Name: Iphone 8")
                    .font(.title)
                    .padding(5)
                Text("Condition: Good")
                    .font(.headline)
                    .fontWeight(.regular)
                    .padding(5)
                Text("Price: 500")
                    .font(.headline)
                    .fontWeight(.regular)
                    .padding(5)
                
            }
            .padding()
            
            MapView()
                .frame(height: 300)
        }
    }
}

struct ProductDetails_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetails()
    }
}
