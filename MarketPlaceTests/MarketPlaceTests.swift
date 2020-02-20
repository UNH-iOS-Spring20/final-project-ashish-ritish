//
//  MarketPlaceTests.swift
//  MarketPlaceTests
//
//  Created by Ashish Shrestha on 2/17/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import XCTest
@testable import MarketPlace

class MarketPlaceTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testProductItemInitSucceds(){
           let car = ProductItem.init(name: "Honda", category: "Vechile", condition: "New", email: "ashre1@unh.newhave.edu", date: "02/16/2020", price: 2000.00)
           XCTAssertNotNil(car)
        
            let phone = ProductItem.init(name: "iphone", category: "Electronic", condition: "Used", email: "rkark1@unh.newhave.edu", date: "02/11/2020", price: 600.50)
            XCTAssertNotNil(phone)
            
    }
    
    func testProductItemInitFails(){
        let noProductName = ProductItem.init(name: "", category: "Vechile", condition: "New", email: "ashre1@unh.newhaven.edu", date: "02/16/2020", price: 2000.00)
        XCTAssertNil(noProductName)
        
        let noProductCategory = ProductItem.init(name: "", category: "", condition: "New", email: "ashre1@unh.newhaven.edu", date: "02/16/2020", price: 2000.00)
        XCTAssertNil(noProductCategory)
        
        let noUserEmail = ProductItem.init(name: "", category: "Vechile", condition: "New", email: "", date: "02/16/2020", price: 2000.00)
        XCTAssertNil(noUserEmail)
        
        let noPostDate = ProductItem.init(name: "", category: "Vechile", condition: "New", email: "ashre1@unh.newhaven.edu", date: "", price: 2000.00)
        XCTAssertNil(noPostDate)
        
        let negProdPrice = ProductItem.init(name: "", category: "Vechile", condition: "New", email: "ashre1@unh.newhaven.edu", date: "02/16/2020", price: 2000.00)
        XCTAssertNil(negProdPrice)
    }
    
    func testProductItemListItem(){
        
        let car = ProductItem.init(name: "Honda", category: "Vechile", condition: "New", email: "ashre1@unh.newhave.edu", date: "02/16/2020", price: 2000.00)
        let phone = ProductItem.init(name: "iphone", category: "Electronic", condition: "Used", email: "rkark1@unh.newhave.edu", date: "02/11/2020", price: 600.50)
        
        let lists = ListingCart.init()
        XCTAssertEqual(0, lists.items.count)
        lists.listItem(item: car!)
        XCTAssertEqual(1, lists.items.count)
        lists.listItem(item: phone!)
        XCTAssertEqual(2, lists.items.count)
    }

    func testUserProfileInitSucceds(){
        let user1 = UserProfile.init(name:"Ritish Karki", email:"rkark1@unh.newhaven.edu", contactNumber:"203-435-3851", zipCode:"06516", address:"21 andrews street")
        XCTAssertNotNil(user1)
    }

    func testUserProfileInitFails(){
        let noNameUser = UserProfile.init(name:"", email:"rkark1@unh.newhaven.edu", contactNumber:"203-435-3851", zipCode:"06516", address:"21 andrews street")
        XCTAssertNil(noNameUser)

        let noEmailUser = UserProfile.init(name:"Ritish karki", email:"", contactNumber:"203-435-3851", zipCode:"06516", address:"21 andrews street")
        XCTAssertNil(noEmailUser)

        let noContactUser = UserProfile.init(name:"R karki", email:"rkark1@unh.newhaven.edu", contactNumber:"", zipCode:"06516", address:"21 andrews street")
        XCTAssertNil(noContactUser)
    }
}
