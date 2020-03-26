//
//  ListView.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 3/19/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI

struct ListScreenView: View {
    @State var selected = 0
    var lists = ["Favorite", "Selling", "Sold", "Brought"]
    
    var body: some View {
            VStack{
                Picker(selection: $selected, label: Text(""), content: {
                   ForEach(0 ..< lists.count) {
                      Text(self.lists[$0])
                   
                    
                   }
                    
                }).pickerStyle(SegmentedPickerStyle())
                    .font(.headline)
                Spacer()
                Text(lists[selected])
                    .font(.headline)
                    .padding(.bottom, 30)
                
                }
            //.padding()
        .navigationBarTitle(Text("Listing"), displayMode: .inline)
        
    }
}

struct ListScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ListScreenView()
    }
}
