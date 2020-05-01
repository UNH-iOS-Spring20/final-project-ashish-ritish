//
//  AddProductView.swift
//  MarketPlace
//
//  Created by Ashish-Ritish on 4/13/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI
import CoreLocation

struct AddProductView: View {
    let categorysArray = ["Auto Motive", "Cell Phone", "Computer", "Electronics", "Fashion", "Household", "Music", "Real Estate", "Rental", "Sports", "Stationery", "Others"]
    
    let conditionArray = ["New", "Like new", "Good", "Fair", "Poor"]
    
    
    @State var name = ""
    @State var price = ""
    @State var categorySelected = ""
    @State var conditionSelected = ""
    @State var productDescription = ""
    @State var show = false
    @State var choice = false
    @State private var refresh = false
    @State var loading = false
    var data: [String] = []
    @State var latitude = 0.0
    @State var longitude = 0.0
    
    @State var showImagePicker = false
    @State var selectedImages : [UIImage] = []
    
    func clear(){
        name = ""
        price = ""
        categorySelected = ""
        conditionSelected = ""
        productDescription = ""
        selectedImages.removeAll()
    }
    
    func addNewProduct(){
        let geocoder = CLGeocoder()
        let address = Defaults.getUserDetails().address + " " + Defaults.getUserDetails().zipCode
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("Error", error ?? "")
            }
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                self.latitude = coordinates.latitude
                self.longitude = coordinates.longitude
                addProduct(name: self.name,price : self.price,images : self.selectedImages, category: self.categorySelected, condition: self.conditionSelected, latitude: self.latitude, longitude: self.longitude, description: self.productDescription){ completed in
                    
                    if(completed){
                        CreateNotification(title: "New Product Added", message: "\(self.name) has been added", isPublic: false)
                        self.refresh.toggle()
                        self.clear()
                        self.loading.toggle()
                    }else{
                        print("failed operation")
                    }
                }
            }
        })
        
        
        
    }
    
    var body: some View {
        NavigationView{
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
                                TextField("Product Category" + (refresh ? "" : " "), text: $categorySelected)
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
                                TextField("Product Condition" + (refresh ? "" : " "), text: $conditionSelected)
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
                                    self.addNewProduct()
                                    self.loading.toggle()
                                }) {
                                    
                                    Text("Add").foregroundColor(.white).frame(width: UIScreen.main.bounds.width-200).padding()
                                    
                                    
                                }.background(Color("appBlue"))
                                    .clipShape(Capsule())
                                    .padding(.top, 10)
                                
                                Spacer()
                            }
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
            .navigationBarTitle(Text("Add Product"), displayMode: .inline)
        }
    }
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView()
    }
}
