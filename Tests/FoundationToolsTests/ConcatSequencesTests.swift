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

class ConcatSequencesTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testTwoArraysCanBeConcatenatedLazily() {
        let a = [4, 5, 6]
        let b = [1, 2]
        
        XCTAssertEqual(a + b, Array(a <+> b))
    }
    
    func testTwoArraysCanBeConcatenatedLazilyIfOneArrayIsEmpty() {
        let a = [4, 5, 6]
        let b = [1, 2]
        let empty: [Int] = []
        
        XCTAssertEqual(a + empty, Array(a <+> empty))
        XCTAssertEqual(empty + b, Array(empty <+> b))
        XCTAssertEqual(empty, Array(empty <+> empty))
    }
    
    func testConcatenationCanBeReused() {
        let a = [4, 5, 6]
        let b = [1, 2]
        let c = a <+> b
        
        XCTAssertEqual(a + b, Array(c))
        XCTAssertEqual(a + b, Array(c))
    }
    
    func testRangesCanBeConcatenatedDirectly() {
        XCTAssertEqual(Array(1...10), Array(1...4 <+> 5...10))
    }
    
    static var allTests : [(String, (ConcatSequencesTests) -> () throws -> Void)] {
        return [
            ("testTwoArraysCanBeConcatenatedLazily", testTwoArraysCanBeConcatenatedLazily),
            ("testTwoArraysCanBeConcatenatedLazilyIfOneArrayIsEmpty", testTwoArraysCanBeConcatenatedLazilyIfOneArrayIsEmpty),
            ("testConcatenationCanBeReused", testConcatenationCanBeReused),
            ("testRangesCanBeConcatenatedDirectly", testRangesCanBeConcatenatedDirectly)
        ]
    }
}
