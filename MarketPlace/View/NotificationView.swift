//
//  NotificationView.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 3/19/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI

struct NotificationView: View {
    @State private var showingSheet = false
    
    var actionSheet: ActionSheet{
        ActionSheet(title: Text(""), message: Text("Title"), buttons: [
                 // .default(Text("Delete")),
                  .destructive(Text("Delete"), action: {
                      print("Delete")
                  }),
                .cancel()
              ])
    }
    var body: some View {
        List{
            HStack(){
                Image("AppLogo")
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 4)
                    .scaledToFit()
                // .padding(20)
                HStack() {
                    VStack(alignment: .leading) {
                        Text("Title")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .fixedSize(horizontal: false, vertical: true)
                            .layoutPriority(98)
                        Text("Details")
                            .font(.headline)
                            .foregroundColor(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                            .layoutPriority(99)
                    }
                   // .padding(.top, 0)
                        //  .background(Color.red)
                        .padding(10)
                    Spacer()
                    Button(action : {
                        self.showingSheet = true
                    }){
                        Image(systemName: "ellipsis")
                    }
                    .actionSheet(isPresented: $showingSheet, content: {
                               self.actionSheet })
                    
                }
                
            }.padding(10)
                //.frame(height: 10)
                .navigationBarTitle(Text("Notifications"), displayMode: .inline)
               
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
