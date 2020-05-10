//
//  createAccount.swift
//  MarketPlace
//
//  Created by Ashish-Ritish on 4/15/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI
struct CreateAccount : View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var show : Bool
    @State var name = ""
    @State var about = ""
    @State var phoneNumber = ""
    @State var zipCode = ""
    @State var location = ""
    @State var picker = false
    @State var loading = false
    @State var imagedata : Data = .init(count: 0)
    @State var alert = false
    
    func dismiss() {
        self.name=""
        self.about = ""
        self.phoneNumber = ""
        self.zipCode = ""
        self.location = ""
        self.loading = false
        self.imagedata = .init(count: 0)
        presentationMode.wrappedValue.dismiss()
    }
    
    var body : some View{
        
        VStack(alignment: .leading, spacing: 15){
            HStack{
                Spacer()
                Text("Create your profile").fontWeight(.heavy).font(.largeTitle).padding([.top,.bottom], 20)
                Spacer()
            }
            
            HStack{
                
                Spacer()
                
                Button(action: {
                    
                    self.picker.toggle()
                    
                }) {
                    
                    if self.imagedata.count == 0{
                        
                       Image(systemName: "person.crop.circle.badge.plus").resizable().frame(width: 90, height: 70).foregroundColor(.gray)
                    }
                    else{
                        
                        Image(uiImage: UIImage(data: self.imagedata)!).resizable().renderingMode(.original).frame(width: 90, height: 90).clipShape(Circle())
                    }
                    
                    
                }
                
                Spacer()
            }
            .padding(.vertical, 15)
            
            VStack(alignment: .leading){
                
                Text("Name").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                
                HStack{
                    
                    TextField("Enter Your Name", text: $name)
                    
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
                Text("Phone Number").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))

                HStack{
                    
                    TextField("Number", text: $phoneNumber)
                    .keyboardType(.numberPad)
                    
                }
                
                Divider()
                
            }.padding(.bottom, 15)
            
            VStack(alignment: .leading){
                
                Text("Zip Code").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                
                HStack{
                    TextField("Enter your area Zip code", text: $zipCode)
                }
                
                Divider()
                
            }.padding(.bottom, 15)
            
            VStack(alignment: .leading){
                
                Text("Location").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                
                HStack{
                    TextField("Enter your location", text: $location)
                }
                
                Divider()
                
            }.padding(.bottom, 15)
            
            VStack(alignment: .leading){
                
                Text("About You").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                
                HStack{
                    
                    TextField("Write something about yourself", text: $about)
                    
                    if about != ""{
                        Image(systemName: "checkmark")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 23)
                            .foregroundColor(Color.init(.label))
                    }
                    
                }
                
                Divider()
                
            }.padding(.bottom, 15)
            
            if self.loading{
                
                HStack{
                    
                    Spacer()
                    
                    Indicator()
                    
                    Spacer()
                }
            }
                
            else{
                
                Button(action: {
                    
                    if self.name != "" && self.about != "" && self.imagedata.count != 0 && self.zipCode != "" && self.phoneNumber != "" && self.location != ""{
                        
                        self.loading.toggle()
                        CreateUser(name: self.name, about: self.about, imagedata: self.imagedata, zipCode: self.zipCode, phoneNumber: self.phoneNumber, location: self.location) { (status, url) in
                            CreateNotification(title: "Account Created", message: "Your account was sucessfully created", isPublic: false)
                            if status{
                                self.show = false
                                self.dismiss()
                            }
                        }
                    }
                    else{
                        
                        self.alert.toggle()
                    }
                    
                    
                }) {
                    

                Text("Create Profile").frame(width: UIScreen.main.bounds.width - 30,height: 50)
                         
                }.foregroundColor(.white)
                .background(Color("appBlue"))
                .cornerRadius(10)
                
            }
            
        }
        .padding()
        .sheet(isPresented: self.$picker, content: {
            ImagePicker(picker: self.$picker, imagedata: self.$imagedata)
        })
        .alert(isPresented: self.$alert) {
            
            Alert(title: Text("Message"), message: Text("Please Fill The Contents"), dismissButton: .default(Text("Ok")))
        }
    }
}
