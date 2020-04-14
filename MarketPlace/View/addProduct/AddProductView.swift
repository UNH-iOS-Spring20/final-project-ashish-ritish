//
//  AddProductView.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 4/13/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI

struct AddProductView: View {
    var body: some View {
        NavigationView{
        Color.purple
       .navigationBarTitle(Text("Add Product"), displayMode: .inline)
        }
    }
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView()
    }
}
