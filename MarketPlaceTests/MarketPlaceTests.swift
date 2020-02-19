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

}
