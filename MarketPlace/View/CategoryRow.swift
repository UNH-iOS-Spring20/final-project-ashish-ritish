//
//  CategoryRow.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 3/17/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI

struct CategoryRow: View {
 //  var categories: [Category]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                ForEach(0..<10) {
                    Text("\($0)")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .frame(width: 50, height: 50)
                        .background(Color.red)
                }
            }
        }
        
     //   Text(categories[0].name)
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRow()
    }
}
