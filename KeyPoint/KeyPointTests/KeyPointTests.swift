//
//  KeyPointTests.swift
//  KeyPointTests
//
//  Created by Jason Jiang on 2018/4/21.
//  Copyright © 2018年 Jason. All rights reserved.
//

import XCTest

class KeyPointTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        print("i am unit test")
        XCTAssert(3 > 2)
        let ui = UIButton(type: .custom)
        print("lll\(ui)")
        ui.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
