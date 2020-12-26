//
//  SikaTests.swift
//  SikaTests
//
//  Created by KWAME DARKO on 8/9/20.
//  Copyright © 2020 KWAME DARKO. All rights reserved.
//

import XCTest
@testable import Sika

class SikaTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testremoveuserDefault() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        var defaults = UserDefaults()
        
        defaults.removeObject(forKey: "accRefId")
        
        XCTAssertNil(defaults.string(forKey: "accRefId"))
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
