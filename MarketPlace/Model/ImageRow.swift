//
//  ImageRow.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 3/4/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI
import Combine

struct ImageRow: View {
    var body: some View {
        var images: [[Int]] = []
        
        _ = (1...6).publisher
            .collect(2)
            .collect()
            .sink(receiveValue: { images = $0 })
        
        return ForEach(0..<images.count, id: \.self) { array in
            HStack{
                ForEach(images[array], id: \.self) { number in
                    Image(productDatas[number].imageName)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                }
                
            }
        }
    }
}
