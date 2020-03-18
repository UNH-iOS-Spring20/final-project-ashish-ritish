//
//  Home.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 3/3/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI



struct Home: View {
    
    
    @State var showingprofile = false
    @State private var searchText: String = ""
    
    var userdata = " Name: Ritish Karki\n\n Email: rkark1@unh.newhaven.edu " + "\n\n Contact: +2034353851\n\n Address: 2 Andrew Street Apt 1B\n\n City: West Haven"
        + "\n\n State: CT\n\n ZipCode: 06516"
    
    var profileButton: some View{
        Button(action: { self.showingprofile.toggle()}){
            Image(systemName: "person.crop.circle")
                .imageScale(.large)
                .accessibility(label: Text("User Profile"))
                .padding()
        }
    }
    
    var body: some View {
        NavigationView {
            VStack{
                SearchBar(text: $searchText, placeholder: "Search")
                CategoryRow()
                
                //   List(productDatas) { productData in
                List {
                    ForEach(productDatas) { productData in
                        NavigationLink(destination: ProductDetails(product: productData)){
                            HStack{
                                //  ForEach(0..<2) { index in
                                Image(productData.imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 180, height: 180, alignment: .center)
                                
                                VStack {
                                    Text(productData.name)
                                        .font(.title)
                                    Text("$ " + String(productData.price))
                                        .font(.headline)
                                }
                                .padding(20)
                                //   }
                                
                            }
                        }
                    }
                    //  .navigationBarTitle(Text("Products"))
                }
                .navigationBarItems(leading: profileButton)
                .sheet(isPresented: $showingprofile){
                    VStack{
                        HStack{
                            Text("User Profile")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(10)
                            Spacer()
                            Image("karki")
                                .edgesIgnoringSafeArea(.top)
                                .clipShape(Circle())
                                .overlay(
                                    Circle().stroke(Color.white, lineWidth: 4))
                                .shadow(radius: 10)
                                .edgesIgnoringSafeArea(.top)
                                .scaledToFit()
                            //  .padding(20)
                        }
                        .padding(.bottom, 20)
                        Text(self.userdata)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                    }
                    .padding()
                }
            }
        }
    }
}



struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
