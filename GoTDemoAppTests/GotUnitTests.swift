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

    func testHouseModel_canCreateInstance(){
        let instance = House(url: "www.test.com", name: "stark", region: "north", words: "we are the north", titles: ["king of the north", "northern stone throne"], currentLord: "ricardo", heir: "lil jimmy", founded: "in the ancient times", swornMembers: ["mike","rob","jakob"])
        
        XCTAssertNotNil(instance)
    }
    
    func testHouseModel_canCreateAttributes(){
        
        let house = House(url: "www.test.com", name: "stark", region: "north", words: "we are the north", titles: ["king of the north", "northern stone throne"], currentLord: "ricardo", heir: "lil jimmy", founded: "in the ancient times", swornMembers: ["mike","rob","jakob"])
        
        let attributes = house.houseAttributes()
        
        XCTAssertNotNil(attributes)
    }
    
    func testCharacterModel_canCreateInstance(){
        let instance = Character(url: "www.test.com", name: "edward", born: "a cool july morning", titles: ["th disappointment"])
        
        XCTAssertNotNil(instance)
    }

}
