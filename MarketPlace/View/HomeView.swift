//
//  HomeView.swift
//  MarketPlace
//
//  Created by Ashish-Ritish on 3/19/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseFirestore

struct HomeView: View {
    @State private var searchText: String = ""
    @State private var isNavigationBarHidden = true
    @State private var showingProfile = false
    @ObservedObject var viewRouter: ViewRouter
    
    @ObservedObject private var products = FirebaseCollection<Product>(collectionRef: productsCollectionRef)
    @ObservedObject private var categories = FirebaseCollection<Category>(collectionRef: categoriesCollectionRef)
 
    var profileButton: some View{
        Button(action: {
            self.showingProfile.toggle()
        }){
            WebImage(url: URL(string: (Defaults.getUserDetails().photoUrl)))
            .onSuccess { image, cacheType in
                // Success
            }
            .resizable()
            .placeholder(Image(systemName: "person.crop.circle")) // Placeholder Image
            .renderingMode(.original)
            .indicator(.activity)
            .clipShape(Circle())
            .animation(.easeInOut(duration: 0.5)) // Animation Duration
            .transition(.fade) // Fade Transition
            .scaledToFit()
            .frame(width: 40, height: 40, alignment: .center)
            .aspectRatio(contentMode: .fit)
        }
    }
    
    var body: some View {

        NavigationView{
            VStack(spacing: 0){
                // stack for top search bar
                HStack(spacing: 0){
                    profileButton
                    SearchBar(text: $searchText, placeholder: "Search")
                }.padding(.leading, 7.5)
                
                // stack for category slider
                CategoryRow(items: categories.items)
                //
                VStack{
                    if(self.products.items.count > 0){
                        ProductsCollectionView(products: self.products.items.filter {
                            $0.addBy != uid! && $0.soldTo.isEmpty && (self.searchText.isEmpty ? true : $0.name.lowercased().contains(self.searchText.lowercased()))
                       })
                    }else{
                         noProduct(message: "No user has added any products yet.")
                    }
                }.sheet(isPresented: $showingProfile){
                    return UserProfileView(viewRouter: self.viewRouter, isPresented: self.$showingProfile)
                }
            }
            .navigationBarHidden(isNavigationBarHidden)
            .navigationBarTitle("Home", displayMode: .inline)
            .onAppear {
                self.isNavigationBarHidden = true
                print(uid!)
            }
            .onDisappear {
                self.isNavigationBarHidden = false
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewRouter: ViewRouter())
    }
}
