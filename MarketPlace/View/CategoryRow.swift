//
//  CategoryRow.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 3/17/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//
import SwiftUI

struct CategoryRow: View {
    var items: [Category]
    var categoryName="Sample"
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center) {
              ForEach(items, id: \.self.id) { category in
                VStack{
                    CategoryImage(picture: category.name)
                    Text(category.name)
                }.padding()
               }
            }.frame(height: 120)
        }
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRow(
            items: firebaseSession.categories
        )
    }
}
