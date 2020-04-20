//
//  HomeView.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 3/19/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI
import WaterfallGrid
import SDWebImageSwiftUI
import FirebaseFirestore

let productsCollectionRef = Firestore.firestore().collection("products")
let categoriesCollectionRef = Firestore.firestore().collection("categories")


struct HomeView: View {
    @State private var searchText: String = ""
    @State private var isNavigationBarHidden = true
    @State private var showingProfile = false
    var collection: [[Product]] = []
    @EnvironmentObject var userProfile: UserProfile
    @ObservedObject var viewRouter: ViewRouter
    
    @ObservedObject private var products = FirebaseCollection<Product>(collectionRef: productsCollectionRef)
    @ObservedObject private var categories = FirebaseCollection<Category>(collectionRef: categoriesCollectionRef)
    
    var profileButton: some View{
       WebImage(url: URL(string: (self.userProfile.photoUrl)))
        .onSuccess { image, cacheType in
            // Success
        }
        .resizable()
        .placeholder {
            Circle().foregroundColor(.gray)
        }
        .renderingMode(.original)
        .indicator(.activity)
        .clipShape(Circle())
        .animation(.easeInOut(duration: 0.5)) // Animation Duration
        .transition(.fade) // Fade Transition
        .scaledToFit()
        .frame(width: 40, height: 40, alignment: .center)
        .aspectRatio(contentMode: .fit)
        .onTapGesture {
           self.showingProfile.toggle()
        }
    }
    
    var body: some View {
        NavigationView{
            VStack(spacing: 0){
                // stack for top search bar
                HStack(spacing: 0){
                    profileButton
                    SearchBar(text: $searchText, placeholder: "Search")
                }
                
                // stack for category slider
                CategoryRow(items: categories.items)
                
                
//                //list of products displayed in grid style suing waterfall grid
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
                    
                    .sheet(isPresented: $showingProfile){
                        UserProfileView(viewRouter: self.viewRouter, isPresented: self.$showingProfile)
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


//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(viewRouter: ViewRouter())
//    }
//}
