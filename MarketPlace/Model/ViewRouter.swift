//
//  ViewRouter.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 3/27/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class ViewRouter: ObservableObject {
    
    let objectWillChange = PassthroughSubject<ViewRouter, Never>()
    
    @Published var itemColor = "home"
    
    var currentView = "home" {
        didSet{
            objectWillChange.send(self)
        }
    }
    
    var currentPage: String = "loginPage"{
        didSet{
            objectWillChange.send(self)
        }
    }
    
}
