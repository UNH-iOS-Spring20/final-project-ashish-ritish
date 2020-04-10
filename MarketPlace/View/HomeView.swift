//
//  HomeView.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 3/19/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI
import WaterfallGrid
import FirebaseFirestore

let productsCollectionRef = Firestore.firestore().collection("products")
let categoriesCollectionRef = Firestore.firestore().collection("categories")

struct HomeView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var showingprofile = false
    @State private var searchText: String = ""
    @State private var isNavigationBarHidden = true
    
    @ObservedObject private var products = FirebaseCollection<Product>(collectionRef: productsCollectionRef)
    @ObservedObject private var categories = FirebaseCollection<Category>(collectionRef: categoriesCollectionRef)
    
    var userdata = " Name: Ritish Karki\n\n Email: rkark1@unh.newhaven.edu " + "\n\n Contact: +2034353851\n\n Address: 2 Andrew Street Apt 1B\n\n City: West Haven"
        + "\n\n State: CT\n\n ZipCode: 06516"
    
    var profileButton: some View{
        Button(action: { self.showingprofile.toggle()}){
            Image("karki")
                .renderingMode(.original)
                .resizable()
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(Color.white, lineWidth: 2)
                )
                .frame(width: 40, height: 40, alignment: .center)
                .shadow(radius: 2)
                .aspectRatio(contentMode: .fit)
                .accessibility(label: Text("User Profile"))
              .padding(5)
        }
    }
    
    func dismiss() {
           presentationMode.wrappedValue.dismiss()
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
                CategoryRow(items: categories.items)
                
                
                //list of products displayed in grid style suing waterfall grid
                WaterfallGrid(self.products.items.filter {
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
            .navigationBarTitle("Home", displayMode: .inline)
            .onAppear {
                self.isNavigationBarHidden = true
            }
            .onDisappear {
                self.isNavigationBarHidden = false
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
