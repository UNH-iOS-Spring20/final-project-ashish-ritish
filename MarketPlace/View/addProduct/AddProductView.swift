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
    @ObservedObject var locationManager = LocationManager()
    var userLatitude: String {
        return "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
    }
    
    var userLongitude: String {
        return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
    }
    
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
    var data: [String] = []
    
    @State var showImagePicker = false
    @State var selectedImages : [UIImage] = []
    
    func getCoordinate(){
        let geocoder = CLGeocoder()
        let address = Defaults.getUserDetails().address + " " + Defaults.getUserDetails().zipCode
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("Error", error ?? "")
            }
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
            }
        })
    }
    
    func clear(){
        name = ""
        price = ""
        categorySelected = ""
        conditionSelected = ""
        productDescription = ""
    }
    
    func addNewProduct(){
        
//        print(self.name, self.price, self.categorySelected, self.conditionSelected, self.productDescription, Defaults.getUserDetails().id, Defaults.getUserDetails().email, self.productDescription, self.selectedImages, userLongitude, userLatitude)
        
        addProduct(name: self.name,price : self.price,images : self.selectedImages, category: self.categorySelected, condition: self.conditionSelected, latitude: self.userLatitude, longitude: self.userLongitude, description: self.productDescription){ completed in
            
            if(completed){
                self.refresh.toggle()
                self.clear()
            }else{
                print("failed operation")
            }
        }
        

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
                                                .frame(width: UIScreen.main.bounds.width / 2 - 40, height: 150)
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
                                .padding(.top, 25)
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
                        }.padding(.bottom, 10)
                        
                        
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
                        }.padding(.bottom, 10)
                        
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
                        }.padding(.bottom, 10)
                        
                        VStack(alignment: .leading) {
                            Text("Category").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                            HStack {
                                TextField("Product Category" + (refresh ? "" : " "), text: $categorySelected)
                                    .disabled(true)
                                Button(action: {
                                    self.choice = true
                                    self.show.toggle()
                                    print("Category")
                                }){
                                    Image(systemName: "chevron.down")
                                }
                            }
                            Divider()
                        }.padding(.bottom, 10)
                        
                        VStack(alignment: .leading) {
                            Text("Condition").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                            HStack {
                                TextField("Product Condition" + (refresh ? "" : " "), text: $conditionSelected)
                                    .disabled(true)
                                Button(action: {
                                    self.choice = false
                                    self.show.toggle()
                                    print("Condition")
                                }){
                                    Image(systemName: "chevron.down")
                                }
                            }
                            Divider()
                        }.padding(.bottom, 10)
                        
                        
                        HStack{
                            Spacer()
                            Button(action: {
                                self.getCoordinate()
                                self.addNewProduct()
                            }) {
                                
                                Text("Add").foregroundColor(.white).frame(width: UIScreen.main.bounds.width-200).padding()
                                
                                
                            }.background(Color("appBlue"))
                                .clipShape(Capsule())
                                .padding(.top, 10)
                            
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
            .navigationBarTitle(Text("Add Product"), displayMode: .inline)
        }
    }
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView()
    }
}
