//
//  ListView.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 3/19/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI

struct ListScreenView: View {
    @State var itemColor = "favorite"
    
    
    var body: some View {
       NavigationView{
        GeometryReader{ geometry in
            VStack(spacing: -4){
                HStack(spacing: 0){
                    
                    VStack(spacing: 5){
                        Text("Favorite")
                            .font(.system(size: 18))
                            .foregroundColor(self.itemColor == "favorite" ? .blue : .gray)
                        Image(systemName: "minus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 10)
                            .foregroundColor(self.itemColor == "favorite" ? .blue : .clear)
                    }
                    .onTapGesture {
                            self.itemColor = "favorite"
                    }
                    
                    VStack(spacing: 5){
                        Text("Selling")
                            .font(.system(size: 18))
                            .foregroundColor(self.itemColor == "selling" ? .blue : .gray)
                        Image(systemName: "minus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 10)
                            .foregroundColor(self.itemColor == "selling" ? .blue : .clear)
                    }
                    .onTapGesture {
                            self.itemColor = "selling"
                    }
                    
                    VStack(spacing: 5){
                        Text("Sold")
                            .font(.system(size: 18))
                            .foregroundColor(self.itemColor == "sold" ? .blue : .gray)
                        Image(systemName: "minus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 10)
                            .foregroundColor(self.itemColor == "sold" ? .blue : .clear)
                    }
                        
                    .onTapGesture {
                            self.itemColor = "sold"
                    }
                    
                    VStack(spacing: 5){
                        Text("Brought")
                            .font(.system(size: 18))
                            .foregroundColor(self.itemColor == "brought" ? .blue : .gray)
                        Image(systemName: "minus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 10)
                            .foregroundColor(self.itemColor == "brought" ? .blue : .clear)
                    }
                        
                    .onTapGesture {
                            self.itemColor = "brought"
                    }
                    
                } .frame(width: geometry.size.width, height: geometry.size.height/15)
                    .background(Color.white)
                    .padding(.top, 5)
                Spacer()
                Color.red
            }
        }
       .navigationBarTitle(Text("Listing"), displayMode: .inline)
        }
    }
}

struct ListScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ListScreenView()
    }
}
