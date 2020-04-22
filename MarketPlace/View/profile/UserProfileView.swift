//
//  UserProfileView.swift
//  MarketPlace
//
//  Created by Ashish-Ritish on 3/20/20.
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
    @State private var email = ""
    @State private var password = ""
    @State private var userRating = 4
    @Binding var isPresented: Bool
    @State var flag = 0
    
    @EnvironmentObject var userProfile: UserProfile
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
    func navigate(place: String){
        self.viewRouter.selectedTab = place
        self.viewRouter.currentView = place
    }
    
    
    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    GeometryReader { geometry in
                        HStack{
                            WebImage(url: URL(string: (self.userProfile.photoUrl)))
                               .onSuccess { image, cacheType in
                                   // Success
                               }
                               .resizable()
                               .placeholder(Image(systemName: "person.crop.circle")) // Placeholder Image
                               .renderingMode(.original)
                               .frame(width: 100, height: 100)
                               .clipShape(Circle())
                               .overlay(Circle().stroke(Color.white, lineWidth: 2))
                               .shadow(radius: 10)
                               .edgesIgnoringSafeArea(.top)
                               .scaledToFit()
                               .padding([.top,.bottom], 50)
                               .padding([.leading,.trailing], 20)
                            
                            VStack(alignment: .leading){
                                Text(self.userProfile.name).font(.system(size: 25))
                                Text(self.userProfile.address)
                                Section {
                                    RatingView(rating: self.$userRating)
                                }
                            }.padding(.trailing, 20)
                            Spacer()
                        }
                        .frame(width: geometry.size.width)
                    }
                    
                    HStack(spacing: 10){
                        // go to edit screen section
                        NavigationLink(destination: EditProfile().environmentObject(self.userProfile)){
                            HStack {
                                Text("edit").foregroundColor(Color.white)
                                Image(systemName: "pencil").foregroundColor(Color.white)
                            }.padding(10.0)
                        }.background(Color("appBlue"))
                        .clipShape(Capsule())
                        
                        // go to notification screen
                        Button(action: {
                            self.dismiss()
                            self.flag = 1
                        }) {
                            HStack {
                                Image(systemName: "bell.fill").foregroundColor(Color.white)
                                Text("Notification").foregroundColor(Color.white)
                            }.padding(10.0)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10.0)
                                        .stroke(lineWidth: 2.0)
                            )
                                .foregroundColor(Color.gray)
                        }.background(Color("appBlue"))
                        .clipShape(Capsule())
                        
                        //list section button
                        Button(action: {
                            self.isPresented = false
                            self.flag = 2
                        }) {
                            HStack {
                                Image(systemName: "list.dash").foregroundColor(Color.white)
                                Text("List").foregroundColor(Color.white)
                            }.padding(10.0)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10.0)
                                        .stroke(lineWidth: 2.0)
                            )
                                .foregroundColor(Color.gray)
                        }.background(Color("appBlue"))
                        .clipShape(Capsule())
                        
                        Spacer()
                    }
                    .padding(.leading, 20)
                    .padding(.bottom, 10)
                    
                }
                .background(Color(UIColor(red:0, green: 0, blue: 0, alpha: 0.05)))
                .frame(height:200)
                Spacer()
                
                HStack(spacing: 0) {
                    // log out button
                    Button(action: {
                        self.viewRouter.currentPage = "loginPage"
                        try! Auth.auth().signOut()
                           GIDSignIn.sharedInstance()?.signOut()
                           UserDefaults.standard.set(false, forKey: "status")
                           UserDefaults.standard.set([:], forKey: "user")
                           NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                        self.dismiss()
                    }) {
                        Text("Log Out").foregroundColor(.white).frame(width: UIScreen.main.bounds.width - 120).padding()
                    }.background(Color("appBlue"))
                    .clipShape(Capsule())
                    .padding(.top, 45)
                    
                }
            }
            .navigationBarHidden(isNavigationBarHidden)
            .navigationBarTitle("Back", displayMode: .inline)
            .onAppear {
                self.isNavigationBarHidden = true
               // print("aai pugyo", self.userProfile)
            }
            .onDisappear {
                self.isNavigationBarHidden = false
                if self.flag == 2 {
                    self.navigate(place: "list")
                }else if self.flag == 1 {
                    self.navigate(place: "notification")
                }
                
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
