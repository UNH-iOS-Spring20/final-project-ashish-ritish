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
        let guitar = Product.init(
            id: "12s4", data: [
                "name": "guitar",
                "price": 1000.0,
                "email": "karki.ritish@gmail.com",
                "category": "Music",
                "condition": "new",
                "latitude": 41.28758535034469,
                "longitude": -72.96590875763593,
                "description": "very nice guitar",
                "addBy": "bvnzARwG0jX8W2EhufM7X6u3FiG2",
                "soldTo": "",
                "imageUrls": ["https://firebasestorage.googleapis.com/v0/b/marketplace-71120.appspot.com/o/Computer%2FbvnzARwG0jX8W2EhufM7X6u3FiG2DesktopN9znYBvC?alt=media&token=df6aaccb-4c42-4dc7-9cf9-3b4f1b64e34b"],
                "favoriteList": [""]
            ]
        )
        XCTAssertNotNil(guitar)
    }
    
    
    
    func testProductItemInitFails(){
        let noProductName = Product.init(
            id: "12s4", data: [
                "price": 1000.0,
                "email": "karki.ritish@gmail.com",
                "category": "Music",
                "condition": "new",
                "latitude": 41.28758535034469,
                "longitude": -72.96590875763593,
                "description": "very nice guitar",
                "addBy": "bvnzARwG0jX8W2EhufM7X6u3FiG2",
                "soldTo": "",
                "imageUrls": ["https://firebasestorage.googleapis.com/v0/b/marketplace-71120.appspot.com/o/Computer%2FbvnzARwG0jX8W2EhufM7X6u3FiG2DesktopN9znYBvC?alt=media&token=df6aaccb-4c42-4dc7-9cf9-3b4f1b64e34b"],
                "favoriteList": [""]
            ]
        )
        XCTAssertNil(noProductName)
        
        let noProductCategory = Product.init(
            id: "12s4", data: [
                "name": "Guitar",
                "price": 1000.0,
                "email": "karki.ritish@gmail.com",
                "condition": "new",
                "latitude": 41.28758535034469,
                "longitude": -72.96590875763593,
                "description": "very nice guitar",
                "addBy": "bvnzARwG0jX8W2EhufM7X6u3FiG2",
                "soldTo": "",
                "imageUrls": ["https://firebasestorage.googleapis.com/v0/b/marketplace-71120.appspot.com/o/Computer%2FbvnzARwG0jX8W2EhufM7X6u3FiG2DesktopN9znYBvC?alt=media&token=df6aaccb-4c42-4dc7-9cf9-3b4f1b64e34b"],
                "favoriteList": [""]
            ]
        )
        XCTAssertNil(noProductCategory)
    }
    
    func testProductItemListItem(){
        
        let guitar = Product.init(
            id: "12s4", data: [
                "name": "",
                "price": 1000.0,
                "email": "karki.ritish@gmail.com",
                "category": "Music",
                "condition": "new",
                "latitude": 41.28758535034469,
                "longitude": -72.96590875763593,
                "description": "very nice guitar",
                "addBy": "bvnzARwG0jX8W2EhufM7X6u3FiG2",
                "soldTo": "",
                "imageUrls": ["https://firebasestorage.googleapis.com/v0/b/marketplace-71120.appspot.com/o/Computer%2FbvnzARwG0jX8W2EhufM7X6u3FiG2DesktopN9znYBvC?alt=media&token=df6aaccb-4c42-4dc7-9cf9-3b4f1b64e34b"],
                "favoriteList": [""]
            ]
        )
        
        let phone = Product.init(
            id: "12s4", data: [
                "name": "Iphone",
                "price": 500.0,
                "email": "karki.ritish@gmail.com",
                "category": "Electronic",
                "condition": "new",
                "latitude": 41.28758535034469,
                "longitude": -72.96590875763593,
                "description": "very nice iphone",
                "addBy": "bvnzARwG0jX8W2EhufM7X6u3FiG2",
                "soldTo": "",
                "imageUrls": ["https://firebasestorage.googleapis.com/v0/b/marketplace-71120.appspot.com/o/Computer%2FbvnzARwG0jX8W2EhufM7X6u3FiG2DesktopN9znYBvC?alt=media&token=df6aaccb-4c42-4dc7-9cf9-3b4f1b64e34b"],
                "favoriteList": [""]
            ]
        )
        let lists = ListingCart.init()
        XCTAssertEqual(0, lists.items.count)
        lists.listItem(item: guitar!)
        XCTAssertEqual(1, lists.items.count)
        lists.listItem(item: phone!)
        XCTAssertEqual(2, lists.items.count)
    }
    
    
    func testCategoryItemInitFails(){
        let noCategoryName = Category.init(
            id: "12s4", data: [:]
        )
        XCTAssertNil(noCategoryName)
    }
    
    func testNotificationItemInitFails(){
        let noTitle = Notification.init(
            id: "12s4", data: [
                "description": "Your profile was updated sucessfully",
                "createdTime": 1589041468,
                "seenTime": 1589041500,
                "userId": "sOy6rjMA85UVrwHeAkn9Ktpji7s1",
                "clearId": ["sOy6rjMA85UVrwHeAkn9Ktpji7s1"],
                "isPublic": false
            ]
        )
        XCTAssertNil(noTitle)
        
        let noDescription = Notification.init(
            id: "12s4", data: [
                "title":"Profile Updated",
                "createdTime": 1589041468,
                "seenTime": 1589041500,
                "userId": "sOy6rjMA85UVrwHeAkn9Ktpji7s1",
                "clearId": ["sOy6rjMA85UVrwHeAkn9Ktpji7s1"],
                "isPublic": false
            ]
        )
        XCTAssertNil(noDescription)
    }
}
