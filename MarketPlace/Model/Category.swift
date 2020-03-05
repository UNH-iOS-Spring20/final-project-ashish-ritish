//
//  Category.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 3/3/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI

struct Category: View {
    let categories = ["FEATURED", "VECHILES","ELECTRONIC","FASHION","HOUSE","OTHER"]
    var body: some View {
        //ScrollView(.horizontal, showsIndicators: false){
        HStack{
            VStack {
                Image("star-2")
                    .renderingMode(.original)
                    .resizable()
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 4))
                    .frame(width: 70, height: 75)
                    .shadow(radius: 10)
                Text(categories[0])
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .font(.caption)
                
                //  .padding()
            }
            .padding()
            
            VStack {
                Image("star-2")
                    .renderingMode(.original)
                    .resizable()
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 4))
                    .frame(width: 70, height: 75)
                    .shadow(radius: 10)
                Text(categories[0])
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .font(.caption)
                
                //  .padding()
            }
            .padding()
            VStack {
                Image("star-2")
                    .renderingMode(.original)
                    .resizable()
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 4))
                    .frame(width: 70, height: 75)
                    .shadow(radius: 10)
                Text(categories[0])
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .font(.caption)
                
                //  .padding()
            }
            .padding()
            VStack {
                Image("star-2")
                    .renderingMode(.original)
                    .resizable()
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 4))
                    .frame(width: 70, height: 75)
                    .shadow(radius: 10)
                Text(categories[0])
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .font(.caption)
                
                //  .padding()
            }
            .padding()
            VStack {
                Image("star-2")
                    .renderingMode(.original)
                    .resizable()
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 4))
                    .frame(width: 70, height: 75)
                    .shadow(radius: 10)
                Text(categories[0])
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .font(.caption)
                
                //  .padding()
            }
            .padding()
            VStack {
                Image("star-2")
                    .renderingMode(.original)
                    .resizable()
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 4))
                    .frame(width: 70, height: 75)
                    .shadow(radius: 10)
                Text(categories[0])
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .font(.caption)
                
                //  .padding()
            }
            .padding()
            VStack {
                Image("star-2")
                    .renderingMode(.original)
                    .resizable()
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 4))
                    .frame(width: 70, height: 75)
                    .shadow(radius: 10)
                Text(categories[0])
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .font(.caption)
                
                //  .padding()
            }
            .padding()
            VStack {
                Image("star-2")
                    .renderingMode(.original)
                    .resizable()
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 4))
                    .frame(width: 70, height: 75)
                    .shadow(radius: 10)
                Text(categories[0])
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .font(.caption)
                
                //  .padding()
            }
            .padding()
            
            
        }
        
    }
}


struct Category_Previews: PreviewProvider {
    static var previews: some View {
        Category()
    }
}
