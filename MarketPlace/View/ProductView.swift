//
//  ProductView.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 3/19/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI

struct ProductView: View {
    var product: Product
    
    var body: some View {
        VStack() {
            Image(product.imageName)
                /*  .resizable()
                 .aspectRatio(contentMode: .fit)
                 .clipped()
                 .layoutPriority(97)
                 .frame(width: 100, height: 100) */
                 .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                //.clipped()
                .layoutPriority(97)
                .frame(width: 100, height: 100)
            
            HStack() {
                VStack(alignment: .center) {
                    Text(product.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding(.bottom, 8)
                        .fixedSize(horizontal: false, vertical: true)
                        .layoutPriority(98)
                    Text("$ " + String(product.price))
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                        .layoutPriority(99)
                }
                Spacer()
            }
            .padding([.leading, .trailing, .bottom], 8)
        }
        .cornerRadius(8)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.secondary.opacity(0.5))
        )
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(product: firebaseSession.products[0])
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
