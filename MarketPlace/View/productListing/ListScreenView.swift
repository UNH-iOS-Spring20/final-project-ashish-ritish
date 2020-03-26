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
    
    init() {
        //  UISegmentedControl.appearance().apportionsSegmentWidthsByContent = true
        
        
        UISegmentedControl.appearance().selectedSegmentTintColor = .clear
        
        let font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor:
            UIColor.black, NSAttributedString.Key.font: font], for: .selected)
        
        let font1 = UIFont.systemFont(ofSize: 16,weight: UIFont.Weight.medium)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.gray, NSAttributedString.Key.font: font1], for: .normal)
        
        UISegmentedControl.appearance().backgroundColor = .clear
        UISegmentedControl.appearance().tintColor = .clear
        
    }
    
    var body: some View {
        VStack{
            Picker(selection: $selected, label: Text(""), content: {
                ForEach(0 ..< lists.count) {
                    Text(self.lists[$0]).foregroundColor(Color.red)
                }
                
                
            }).pickerStyle(SegmentedPickerStyle())
            //   .frame(height: 50)
            
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
