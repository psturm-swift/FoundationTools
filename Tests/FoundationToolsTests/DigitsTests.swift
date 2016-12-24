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

class DigitsTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testDigitsWorksForIntegersBetween0And9() {
        XCTAssertEqual([6], Array(digitsOf(6)))
        XCTAssertEqual([0], Array(digitsOf(0)))
    }
    
    func testDigitsWorksForIntegersLargerThan10AndEndsWithZero() {
        XCTAssertEqual([0, 4, 3, 2, 1], Array(digitsOf(12340)))
        XCTAssertEqual([0, 0, 0, 9], Array(digitsOf(9000)))
    }

    func testDigitsWorksForIntegersLargerThan10AndEndsNotWithZero() {
        XCTAssertEqual([6, 3, 6, 6, 4], Array(digitsOf(46636)))
        XCTAssertEqual([2, 3], Array(digitsOf(32)))
    }
    
    func testDigitsWorksForNegativeIntegers() {
        XCTAssertEqual([6, 3, 6, 6, 4], Array(digitsOf(-46636)))
        XCTAssertEqual([2, 3], Array(digitsOf(-32)))
    }

    func testDigitsWorksForUnsignedIntegers() {
        XCTAssertEqual([6, 3, 6, 6, 4], Array(digitsOf(UInt(46636))))
        XCTAssertEqual([2, 3], Array(digitsOf(UInt(32))))
    }
    
    func testLazySequenceCreatedByDigitsOfIsReusable() {
        let digits = digitsOf(456)
        let digitsA = Array(digits)
        
        XCTAssertEqual([6, 5, 4], digitsA)
    
        let digitsB = Array(digits)
        XCTAssertEqual(digitsA, digitsB)
    }
    
    static var allTests : [(String, (DigitsTests) -> () throws -> Void)] {
        return [
            ("testDigitsWorksForIntegersBetween0And9", testDigitsWorksForIntegersBetween0And9),
            ("testDigitsWorksForIntegersLargerThan10AndEndsWithZero", testDigitsWorksForIntegersLargerThan10AndEndsWithZero),
            ("testDigitsWorksForIntegersLargerThan10AndEndsNotWithZero", testDigitsWorksForIntegersLargerThan10AndEndsNotWithZero),
            ("testDigitsWorksForNegativeIntegers", testDigitsWorksForNegativeIntegers),
            ("testDigitsWorksForUnsignedIntegers", testDigitsWorksForUnsignedIntegers),
            ("testLazySequenceCreatedByDigitsOfIsReusable", testLazySequenceCreatedByDigitsOfIsReusable)
        ]
    }
}
