//
//  Home.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 3/3/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI
import FirebaseFirestore

struct Home: View {
    
    @ObservedObject var viewRouter = ViewRouter()
    @State var showPopUp = false
    @State var itemColor = "home"
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor.darkGray,
            .font : UIFont(name: "Arial", size: 22)!]
    }
    
    
    var body: some View {
        GeometryReader{ geometry in
            VStack{
                Spacer()
                if self.viewRouter.currentView == "home" {
                    HomeView()
                } else if self.viewRouter.currentView == "notification" {
                    NotificationView()
                }
                else if self.viewRouter.currentView == "sell" {
                    SellView()
                }
                else if self.viewRouter.currentView == "list" {
                    ListScreenView()
                }
                Spacer()
                
                ZStack {
                    if self.showPopUp{
                        PlusMenu()
                            .offset(y: -geometry.size.height/6)
                    }
                    HStack(spacing: 0){
                        VStack(){
                            Image(systemName: "house.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(0)
                                .frame(height: 23)
                            Text("Home")
                                .font(.system(size: 12))
                            
                        }.frame(width: geometry.size.width/5, height: 75)
                           // .foregroundColor(self.viewRouter.currentView == "home" ? .blue : .gray)
                            .foregroundColor(self.itemColor == "home" ? .blue : .gray)
                            .onTapGesture {
                                self.viewRouter.currentView = "home"
                                self.itemColor = "home"
                                if self.showPopUp{
                                    withAnimation{
                                        self.showPopUp.toggle()
                                    }
                                }
                        }
                        VStack(){
                            Image(systemName: "bell.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(0)
                                .frame(height: 23)
                            Text("Notification")
                                .font(.system(size: 12))
                        }.frame(width: geometry.size.width/5, height: 75)
                            .foregroundColor(self.itemColor == "notification" ? .blue : .gray)
                            .onTapGesture {
                                self.viewRouter.currentView = "notification"
                                self.itemColor = "notification"
                                if self.showPopUp{
                                    withAnimation{
                                        self.showPopUp.toggle()
                                    }
                                }
                        }
                        ZStack {
                            Circle()
                                .foregroundColor(Color.white)
                                .frame(width: 65, height: 65)
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 65, height: 65)
                                .foregroundColor(.blue)
                                .overlay(Circle().stroke(Color.white, lineWidth: 3))
                                .shadow(radius: 3)
                                .rotationEffect(Angle(degrees: self.showPopUp ? 135 : 0))
                        }
                        .offset(y: -geometry.size.height/10/2)
                        //  .frame(width: geometry.size.width/5, height: 75)
                        
                        VStack(){
                            Image(systemName: "gear")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(0)
                                .frame(width: geometry.size.width/6, height: 23)
                            Text("Chat")
                                .font(.system(size: 12))
                        }
                        .frame(width: geometry.size.width/5, height: 75)
                        .foregroundColor(self.itemColor == "sell" ? .blue : .gray)
                        .onTapGesture {
                            self.viewRouter.currentView = "sell"
                            self.itemColor = "sell"
                            if self.showPopUp{
                                withAnimation{
                                    self.showPopUp.toggle()
                                }
                            }
                        }
                        VStack(){
                            Image(systemName: "line.horizontal.3")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(0)
                                .frame(width: 27)
                            Text("List")
                                .font(.system(size: 12))
                        }
                        .frame(width: geometry.size.width/5, height: 75)
                             .foregroundColor(self.itemColor == "list" ? .blue : .gray)
                        .onTapGesture {
                            self.viewRouter.currentView = "list"
                            self.itemColor = "list"
                            if self.showPopUp{
                                withAnimation{
                                    self.showPopUp.toggle()
                                }
                            }
                        }
                       
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height/10)
                    .background(Color.white.shadow(radius: 2))
                    
                    
                    
                }
                    //  .offset(y: -geometry.size.height/10/2)
                    .onTapGesture {
                        if(self.itemColor == ""){
                            self.itemColor = self.viewRouter.currentView
                        }
                        else{
                            self.itemColor = ""
                        }
                        withAnimation{
                            self.showPopUp.toggle()
                        }
                }
            }.edgesIgnoringSafeArea(.bottom)
        }
        
        
    }
}

struct PlusMenu: View {
    var body: some View {
        HStack(spacing: 50) {
            ZStack {
                Circle()
                    .foregroundColor(Color.blue)
                    .frame(width: 65, height: 65)
                Image(systemName: "camera")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    .frame(width: 65, height: 65)
                    .foregroundColor(.white)
                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
                    .shadow(radius: 3)
                
            }
            
            ZStack {
                Circle()
                    .foregroundColor(Color.blue)
                    .frame(width: 65, height: 65)
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    .frame(width: 65, height: 65)
                    .foregroundColor(.white)
                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
                    .shadow(radius: 3)
            }
        }
        .transition(.scale)
    }
    
}



struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
