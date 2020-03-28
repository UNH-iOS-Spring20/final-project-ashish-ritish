//
//  HomeView.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 3/19/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI
import WaterfallGrid

struct HomeView: View {
    @ObservedObject private var fbSession = firebaseSession
    @State var showingprofile = false
    @State private var searchText: String = ""
    @State private var isNavigationBarHidden = true
    
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
            VStack(spacing: 0){
                // stack for top search bar
                HStack(spacing: 0){
                    profileButton
                    SearchBar(text: $searchText, placeholder: "Search")
                }
                
                // stack for category slider
                CategoryRow(items: fbSession.categories)
                
                
                //list of products displayed in grid style suing waterfall grid
                WaterfallGrid(self.fbSession.products.filter {
                    self.searchText.isEmpty ? true : $0.name.lowercased().contains(self.searchText.lowercased())
                }, id: \.id) { productData in
                    NavigationLink(destination: ProductDetails(product: productData)){
                        ProductView(product: productData)
                    }
                    
                }
                .gridStyle(
                    columnsInPortrait: 2,
                    columnsInLandscape: 3,
                    spacing: 15,
                    padding: EdgeInsets(top: 7.5, leading: 15, bottom: 7.5, trailing: 15),
                    animation: .easeInOut(duration: 0.5)
                )
                .scrollOptions(
                        direction: .vertical,
                        showsIndicators: true
                )
                    
                .sheet(isPresented: $showingprofile){
                    UserProfileView()
                }
            }
            .navigationBarHidden(isNavigationBarHidden)
            .navigationBarTitle("Back", displayMode: .inline)
            .onAppear {
                    self.isNavigationBarHidden = true
            }
            .onDisappear {
                self.isNavigationBarHidden = false
            }
        }
       // .background(Color.red)
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
