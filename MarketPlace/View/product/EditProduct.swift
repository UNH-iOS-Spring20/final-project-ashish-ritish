//
//  EditProduct.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 4/24/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI
import CoreLocation
import SDWebImageSwiftUI

struct EditProduct: View {
    var categorysArray = ["Auto Motive", "Cell Phone", "Computer", "Electronics", "Fashion", "Household", "Music", "Real Estate", "Rental", "Sports", "Stationery", "Others"]
    
    var conditionArray = ["New", "Like new", "Good", "Fair", "Poor"]
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var product: Product
    @State var name: String = ""
    @State var price: String = ""
    @State var productDescription = ""
    @State var categorySelected: String = ""
    @State var conditionSelected: String = ""
    @State var show = false
    @State var choice = false
    @State var loading = false
    var data: [String] = []
    @State var latitude = 0.0
    @State var longitude = 0.0
    
    @State var showImagePicker = false
    @State var showingAlert = false
    @State var selectedImages : [UIImage] = []
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            ZStack{
                VStack(alignment: .leading){
                    VStack(alignment: .center){
                        
                        if !self.selectedImages.isEmpty{
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                
                                HStack(spacing: 20){
                                    
                                    ForEach(self.selectedImages,id: \.self){i in
                                        
                                        Image(uiImage: i)
                                            .resizable()
                                            .frame(width: UIScreen.main.bounds.width / 2 - 50, height: 120)
                                            .cornerRadius(15)
                                    }
                                }
                                .padding(.horizontal, 20)
                            }
                        }else{
                            ScrollView(.horizontal, showsIndicators: false) {
                                
                                HStack(spacing: 20){
                                    
                                    ForEach(self.product.imageUrls,id: \.self){ url in
                                        
                                        WebImage(url: URL(string: (url)))
                                            .onSuccess { image, cacheType in
                                                // Success
                                        }
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width / 2 - 50, height: 120)
                                        .cornerRadius(15)
                                        
                                    }
                                }
                                .padding(.horizontal, 20)
                            }
                            //    ProductImageView(self.product.imageUrls.map { ProductImage(picture: $0, setHeight: false) })
                        }
                        
                        HStack(spacing: 10) {
                            Spacer()
                            Button(action: {
                                self.showImagePicker.toggle()
                                self.selectedImages.removeAll()
                            }) {
                                
                                Text("Choose product images")
                                    .foregroundColor(.white)
                                    .padding(.vertical,10)
                                    .frame(width: UIScreen.main.bounds.width / 2)
                            }
                            .background(Color("appBlue"))
                            .clipShape(Capsule())
                            .padding(.top, 10)
                            Spacer()
                        }
                    }.padding(.bottom, 15)
                    
                    VStack(alignment: .leading){
                        Text("Name").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                        HStack{
                            TextField("Product Name", text: $name)
                                .onAppear{
                                    self.name = self.product.name
                            }
                            if name != ""{
                                Image(systemName: "checkmark")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 23)
                                    .foregroundColor(Color.init(.label))
                            }
                        }
                        Divider()
                    }.padding(.bottom, 5)
                    
                    
                    
                    VStack(alignment: .leading){
                        Text("Price").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                        HStack{
                            TextField("Product Price", text: $price).keyboardType(.numberPad)
                                .onAppear{
                                    self.price = String(self.product.price)
                            }
                            if price != ""{
                                Image(systemName: "checkmark")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 23)
                                    .foregroundColor(Color.init(.label))
                            }
                        }
                        Divider()
                    }.padding(.bottom, 5)
                    
                    VStack(alignment: .leading){
                        Text("Describe your product").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                        HStack{
                            TextField("Product Description", text: $productDescription)
                                .onAppear{
                                    self.productDescription = String(self.product.description)
                            }
                            if productDescription != ""{
                                Image(systemName: "checkmark")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 23)
                                    .foregroundColor(Color.init(.label))
                            }
                        }
                        Divider()
                    }.padding(.bottom, 5)
                    
                    VStack(alignment: .leading) {
                        Text("Category").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                        HStack {
                            TextField("Product Category", text: $categorySelected)
                                .onAppear{
                                    self.categorySelected = self.product.category
                            }
                            .disabled(true)
                            Button(action: {
                                self.choice = true
                                self.show.toggle()
                            }){
                                Image(systemName: "chevron.down")
                            }
                        }
                        Divider()
                    }.padding(.bottom, 5)
                    
                    VStack(alignment: .leading) {
                        Text("Condition").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                        HStack {
                            TextField("Product Condition", text: $conditionSelected)
                                .onAppear{
                                    self.conditionSelected = self.product.condition
                            }
                            .disabled(true)
                            Button(action: {
                                self.choice = false
                                self.show.toggle()
                            }){
                                Image(systemName: "chevron.down")
                            }
                        }
                        Divider()
                    }.padding(.bottom, 5)
                    
                    
                    HStack{
                        Spacer()
                        if self.loading{
                            HStack{
                                Spacer()
                                Indicator()
                                Spacer()
                            }
                        }
                        else{
                            
                            Button(action: {
                                self.loading.toggle()
                                editProduct(id: self.product.id, name: self.name,price : self.price,images : self.selectedImages, oldUrls: self.product.imageUrls, category: self.categorySelected, condition: self.conditionSelected, description: self.productDescription){ completed in
                                    
                                    if(completed){
                                        CreateNotification(title: "Product Edited", message: "\(self.name) has been modified", isPublic: true)
                                        self.showingAlert.toggle()
                                    }else{
                                        print("failed operation")
                                    }
                                }
                                
                            }) {
                                
                                Text("Save").foregroundColor(.white).frame(width: UIScreen.main.bounds.width-200).padding()
                                
                                
                            }.background(Color("appBlue"))
                                .clipShape(Capsule())
                                .padding(.top, 10)
                        }
                        Spacer()
                    }
                    
                    Spacer()
                    
                }.padding(.horizontal, 20)
                    .padding(.top, 10)
                
                VStack{
                    Spacer()
                    if choice {
                        RadioButtons(selected: self.$categorySelected, show: self.$show, data: categorysArray).offset(y: self.show ? (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 5 : UIScreen.main.bounds.height)
                    }else {
                        RadioButtons(selected: self.$conditionSelected, show: self.$show, data: conditionArray).offset(y: self.show ? (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 25 : UIScreen.main.bounds.height)
                    }
                }.background(Color(UIColor.label.withAlphaComponent(self.show ? 0.2 : 0)).edgesIgnoringSafeArea(.all))
            }
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .animation(.default)
        .sheet(isPresented: $showImagePicker){
            return CustomPicker(selected: self.$selectedImages, show: self.$showImagePicker)
        }
        .navigationBarTitle(Text("Edit \(self.product.name)"), displayMode: .inline)
        .alert(isPresented: $showingAlert) {
                       Alert(title: Text("Product Updated"), message: Text("\(name) was successfully updated"), dismissButton: .default(Text("OK")){
                          
                           self.dismiss()
                           
                           })
                   }
    }
    
}

var sampleProduct = Product(id: "1234", data: [ "name": "Iphone8", "price": 622.00, "email": "rkark1@unh.newhaven.edu", "category": "Cell Phone", "condition": "New", "imageName": "Ihone8", "latitude": 41.26201, "longitude": -72.94621, "description": "Sample phone Data", "isFavorite": true, "imageUrls": ["https://firebasestorage.googleapis.com/v0/b/marketplace-71120.appspot.com/o/Real%20State%2FGhar%2F00B0B_imKuvG07Bhf_600x450.jpg?alt=media&token=b8ef0d5c-dbea-4d71-a6a3-c25416792262",
                                                                                                                                                                                                                                                                                                                 "https://firebasestorage.googleapis.com/v0/b/marketplace-71120.appspot.com/o/Real%20State%2FGhar%2F00m0m_7xa163K3Jyc_600x450.jpg?alt=media&token=2a8749ec-e810-4729-83f6-33faaebde207",
                                                                                                                                                                                                                                                                                                                 "https://firebasestorage.googleapis.com/v0/b/marketplace-71120.appspot.com/o/Real%20State%2FGhar%2F00P0P_57FBcuR9IdY_600x450.jpg?alt=media&token=66afdb55-51f2-4ca7-9053-b906afab8f16"]])

struct EditProduct_Previews: PreviewProvider {
    static var previews: some View {
        EditProduct(product: sampleProduct!)
    }
}
