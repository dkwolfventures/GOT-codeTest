//
//  GotUnitTests.swift
//  GoTDemoAppTests
//
//  Created by Coding on 10/16/21.
//  Copyright © 2021 Vaporstream. All rights reserved.
//

import XCTest
@testable import GoTDemoApp

class GotUnitTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testHouseModel_canCreateInstance(){
        let instance = House(url: "www.test.com", name: "stark", region: "north", words: "we are the north", titles: ["king of the north", "northern stone throne"], currentLord: "ricardo", heir: "lil jimmy", founded: "in the ancient times", swornMembers: ["mike","rob","jakob"])
        
        
    }

}
