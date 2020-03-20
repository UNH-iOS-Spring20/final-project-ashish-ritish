//
//  UserProfileView.swift
//  MarketPlace
//
//  Created by ritish karki on 3/20/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI

struct UserProfileView: View {
    // MARK: - Propertiers
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack() {
            HStack{
                Image("karki")
                .resizable()
                .frame(width:150, height:150)
                .aspectRatio(contentMode: .fit)
                .
            }
           
           Spacer()
           HStack(spacing: 0) {
               Button(action: {}) {
                   Text("Log Out")
                       .foregroundColor(.black)
               }
           }
       }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}

extension Color {
    static var themeTextField: Color {
        return Color(red: 220.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, opacity: 1.0)
    }
}
