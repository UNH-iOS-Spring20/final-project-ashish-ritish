//
//  UserProfileView.swift
//  MarketPlace
//
//  Created by ritish karki on 3/20/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI
import Firebase
import GoogleSignIn
import SDWebImageSwiftUI

struct UserProfileView: View {
    // MARK: - Propertiers
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewRouter: ViewRouter
    @State private var isNavigationBarHidden = true
    @State private var userRating = 4
    @Binding var isPresented: Bool
    @State var flag = 0
    @State var url = Defaults.getUserDetails().photoUrl
    @State var address = Defaults.getUserDetails().address
    @State var zipCode = Defaults.getUserDetails().zipCode
    @State var name = Defaults.getUserDetails().name
    @State var email = Defaults.getUserDetails().email
    @State var phoneNumber = Defaults.getUserDetails().phoneNumber
    @State var about = Defaults.getUserDetails().about
    let publisher = NotificationCenter.default.publisher(for: NSNotification.Name("userDataChanged"))
    
    func dismiss(){
        presentationMode.wrappedValue.dismiss()
    }
    
    func navigate(place: String){
        self.isNavigationBarHidden = false
        self.viewRouter.selectedTab = place
        self.viewRouter.currentView = place
    }
    
    
    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    //notification section
                    HStack(spacing: 10){
                        // go to edit screen section
                        NavigationLink(destination: EditProfile()){
                            HStack {
                                Image(systemName: "pencil").foregroundColor(Color.white)
                            }.padding(15)
                        }.background(Color("appBlue").opacity(0.85))
                        .clipShape(Circle())
                        
                        //every thing to right
                        Spacer()
                        
                        // go to notification screen
                        Button(action: {
                            self.dismiss()
                            self.navigate(place: "notification")
                        }) {
                            HStack {
                                Image(systemName: "bell.fill").foregroundColor(Color.white)
                            }.padding(15)
                        }.background(Color("appBlue").opacity(0.85))
                        .clipShape(Circle())
                        
                        // go to notification screen
                        Button(action: {
                            self.dismiss()
                            self.navigate(place: "fav")
                        }) {
                            HStack {
                                Image(systemName: "heart.fill").foregroundColor(Color.white)
                            }.padding(15)
                        }.background(Color("appBlue").opacity(0.85))
                        .clipShape(Circle())

                        //list section button
                        Button(action: {
                            self.dismiss()
                            self.isPresented = false
                            self.navigate(place: "list")
                        }) {
                            HStack {
                                Image(systemName: "list.dash").foregroundColor(Color.white)
                            }.padding(15)
                        }.background(Color("appBlue").opacity(0.85))
                        .clipShape(Circle())
                    }
                    .padding([.leading,.trailing, .top],20)
                    
                    Spacer()
                }
                .background(Color(UIColor(red:0, green: 0, blue: 0, alpha: 0.05)))
                .frame(height:175)
                
                //user picture
                HStack(alignment: .center){
                       Spacer()
            
                    WebImage(url: URL(string: (self.url)))
                        .onSuccess { image, cacheType in
                        }
                        .onFailure(perform: { (err) in
                            self.url = Defaults.getUserDetails().photoUrl
                        })
                        .resizable()
                        .placeholder(Image(systemName: "person.crop.circle")) // Placeholder Image
                        .renderingMode(.original)
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .shadow(radius: 10)
                        .edgesIgnoringSafeArea(.top)
                        .scaledToFit()
                
                        Spacer()
                }.offset(y: -100)
                
                
                //user profile names
                VStack(alignment: .center){
                    Text(self.name).font(.system(size: 35))
                }.offset(y: -100)

                
                VStack{
                    
                    HStack(spacing: 10){
                        Image(systemName: "star").foregroundColor(Color("appBlue"))
                        Section {
                            RatingView(rating: self.$userRating)
                        }
                        Spacer()
                    }
                    .padding([.leading,.trailing],20)
                    .padding(.bottom, 10)
                    
                    HStack(spacing: 10){
                        Image(systemName: "mappin.and.ellipse").foregroundColor(Color("appBlue"))
                        Text(self.address + " " + self.zipCode ).fontWeight(.medium).font(.system(size: 20))
                        Spacer()
                    }
                    .padding([.leading,.trailing],20)
                    .padding(.bottom, 10)
                    
                    HStack(spacing: 10){
                        Image(systemName: "phone").foregroundColor(Color("appBlue"))
                        Text(self.phoneNumber).fontWeight(.medium).font(.system(size: 20))
                        Spacer()
                    }
                    .padding([.leading,.trailing],20)
                    .padding(.bottom, 10)
                    
                    HStack(spacing: 10){
                        Image(systemName: "envelope").foregroundColor(Color("appBlue"))
                        Text(self.email).fontWeight(.medium).font(.system(size: 20))
                        Spacer()
                    }
                    .padding([.leading,.trailing],20)
                    .padding(.bottom, 10)
                    
                    HStack(spacing: 10){
                        Image(systemName: "person").foregroundColor(Color("appBlue"))
                        Text(self.about).fontWeight(.medium).font(.system(size: 20))
                        Spacer()
                    }
                    .padding([.leading,.trailing],20)
                    .padding(.bottom, 10)
                    
                }.offset(y: -100)
                
                //log out section
                HStack(spacing: 0) {
                    Button(action: {
                        self.dismiss()
                        self.navigate(place: "loginPage")
                        try! Auth.auth().signOut()
                           GIDSignIn.sharedInstance()?.signOut()
                           UserDefaults.standard.set(false, forKey: "status")
                           UserDefaults.standard.set(true, forKey: "NewUser")
                            Defaults.clearUserData()
                            NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                    }) {
                        Text("Log Out").foregroundColor(.white).frame(width: UIScreen.main.bounds.width - 120).padding()
                    }.background(Color("appBlue"))
                    .clipShape(Capsule())
                    .padding(.top, 45)
                }
                
                //push every thing up
                Spacer()
            }
            .navigationBarHidden(isNavigationBarHidden)
            .navigationBarTitle("Back", displayMode: .inline)
            .onAppear {
                self.isNavigationBarHidden = true
            }
            .onReceive(publisher) { (output) in
                self.url = Defaults.getUserDetails().photoUrl
                self.address = Defaults.getUserDetails().address
                self.zipCode = Defaults.getUserDetails().zipCode
                self.name = Defaults.getUserDetails().name
                self.email = Defaults.getUserDetails().email
                self.phoneNumber = Defaults.getUserDetails().phoneNumber
                self.about = Defaults.getUserDetails().about
            }
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(viewRouter: ViewRouter(), isPresented: .constant(false))
    }
}

extension Color {
    static var themeTextField: Color {
        return Color(red: 220.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, opacity: 1.0)
    }
}
