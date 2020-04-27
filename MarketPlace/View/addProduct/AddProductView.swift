//
//  AddProductView.swift
//  MarketPlace
//
//  Created by Ashish-Ritish on 4/13/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI

struct AddProductView: View {
    @ObservedObject var locationManager = LocationManager()
    var userLatitude: String {
        return "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
    }
    
    var userLongitude: String {
        return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
    }
    var categorysArray = ["Auto Motive", "Cell Phone", "Computer", "Electronics", "Fashion", "Household", "Music", "Real Estate", "Rental", "Sports", "Stationery", "Others"]
    
    var conditionArray = ["New", "Like new", "Good", "Fair", "Poor"]
    
    @State var name = ""
    @State var email = ""
    @State var price = ""
    @State var categorySelected = ""
    @State var conditionSelected = ""
    @State var show = false
    @State var choice = false
    @State private var refresh = false
    var data: [String] = []
    
    func clear(){
        name = ""
        email = ""
        price = ""
        categorySelected = ""
        conditionSelected = ""
    }
    
    func addProduct(){
        print(self.name, self.email, self.price, self.categorySelected, self.conditionSelected, self.show, self.choice)
        self.refresh.toggle()
        clear()
    }
    
    var body: some View {
        
        NavigationView{
            
            ZStack{
                VStack(alignment: .leading){
                    VStack(alignment: .leading){
                        Text("Image").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                        HStack(spacing: 10) {
                            Spacer()
                            Image("karki")
                                .resizable()
                                .renderingMode(.original)
                                .frame(width: 100, height: 100)
                                .edgesIgnoringSafeArea(.top)
                                .clipShape(Circle())
                                .overlay(
                                    Circle().stroke(Color.white, lineWidth: 2))
                                .shadow(radius: 5)
                                .edgesIgnoringSafeArea(.top)
                                .scaledToFit()
                            
                            
                            Image("karki")
                                .resizable()
                                .renderingMode(.original)
                                .frame(width: 100, height: 100)
                                .edgesIgnoringSafeArea(.top)
                                .clipShape(Circle())
                                .overlay(
                                    Circle().stroke(Color.white, lineWidth: 2))
                                .shadow(radius: 5)
                                .edgesIgnoringSafeArea(.top)
                                .scaledToFit()
                            
                            Image("karki")
                                .resizable()
                                .renderingMode(.original)
                                .frame(width: 100, height: 100)
                                .edgesIgnoringSafeArea(.top)
                                .clipShape(Circle())
                                .overlay(
                                    Circle().stroke(Color.white, lineWidth: 2))
                                .shadow(radius: 5)
                                .edgesIgnoringSafeArea(.top)
                                .scaledToFit()
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
                    }.padding(.bottom, 15)
                    
                    
                    
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
                    }.padding(.bottom, 15)
                    
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
                    }.padding(.bottom, 15)
                    
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
                    }.padding(.bottom, 15)
                    
                    
                    HStack{
                        Spacer()
                        Button(action: {
                            self.addProduct()
                        }) {
                            
                            Text("Add").foregroundColor(.white).frame(width: UIScreen.main.bounds.width-200).padding()
                            
                            
                        }.background(Color("appBlue"))
                            .clipShape(Capsule())
                            .padding(.top, 20)
                        
                        Spacer()
                    }
                    
                    Spacer()
                    
                }.padding(.horizontal, 20)
                    .padding(.top, 20)
                
                VStack{
                    Spacer()
                    if choice {
                        RadioButtons(selected: self.$categorySelected, show: self.$show, data: categorysArray).offset(y: self.show ? (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 5 : UIScreen.main.bounds.height)
                    }else {
                        RadioButtons(selected: self.$conditionSelected, show: self.$show, data: conditionArray).offset(y: self.show ? (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 25 : UIScreen.main.bounds.height)
                    }
                }.background(Color(UIColor.label.withAlphaComponent(self.show ? 0.2 : 0)).edgesIgnoringSafeArea(.all))
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .animation(.default)
            .navigationBarTitle(Text("Add Product"), displayMode: .inline)
        }
    }
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView()
    }
}
