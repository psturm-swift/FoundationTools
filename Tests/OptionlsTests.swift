/*
 Copyright (c) 2016 Patrick Sturm <psturm.mail@googlemail.com>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

import XCTest
@testable import FoundationTools

class OptionalsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testIfMinWorksForTwoOptionalsWhichAreNotNil() {
        let a: Int? = 4
        let b: Int? = 5
        if let result = min(a,b) {
            XCTAssertEqual(4, result)
        }
        else {
            XCTAssertNotNil(nil)
        }
    }
    
    func testIfMinWorksForTwoOptionalsIfOneIsNil() {
        let a: Int? = 4
        let b: Int? = nil
        let c: Int? = 5
        
        if let result = min(a, b) {
            XCTAssertEqual(4, result)
        }
        else {
            XCTAssertNotNil(nil)
        }

        if let result = min(b, c) {
            XCTAssertEqual(5, result)
        }
        else {
            XCTAssertNotNil(nil)
        }
    }
    
    func testIfMinWorksForTwoOptionalsIfBothAreNil() {
        let a: Int? = nil
        let b: Int? = nil
    
        XCTAssertNil(min(a, b))
    }
    
    func testIfMaxWorksForTwoOptionalsWhichAreNotNil() {
        let a: Int? = 4
        let b: Int? = 5
        if let result = max(a,b) {
            XCTAssertEqual(5, result)
        }
        else {
            XCTAssertNotNil(nil)
        }
    }
    
    func testIfMaxWorksForTwoOptionalsIfOneIsNil() {
        let a: Int? = 4
        let b: Int? = nil
        let c: Int? = 5
        
        if let result = max(a, b) {
            XCTAssertEqual(4, result)
        }
        else {
            XCTAssertNotNil(nil)
        }
        
        if let result = max(b, c) {
            XCTAssertEqual(5, result)
        }
        else {
            XCTAssertNotNil(nil)
        }
    }
    
    func testIfMaxWorksForTwoOptionalsIfBothAreNil() {
        let a: Int? = nil
        let b: Int? = nil
        
        XCTAssertNil(max(a, b))
    }
}
