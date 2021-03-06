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

class CrossProductSequenceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func equal<S: Sequence, T: Sequence>(_ s: S, _ t: T) -> Bool
        where S.Iterator.Element==(Int,Int), T.Iterator.Element==S.Iterator.Element
    {
        let arrayS = Array(s)
        let arrayT = Array(t)
        guard arrayS.count == arrayT.count else { return false }
        for (itemS, itemT) in zip(arrayS, arrayT) {
            guard itemS.0 == itemT.0 && itemS.1 == itemT.1 else { return false }
        }
        return true
    }
    
    func testCrossProducOfTwoArrays() {
        let a = [4, 5, 6]
        let b = [1, 2]
        XCTAssertTrue(equal([(4, 1), (4, 2), (5, 1), (5, 2), (6, 1), (6, 2)], a <*> b))
    }
    
    func testConcatOperatorHasHigherPrecedenceAsCrossProductOperator() {
        let actual = 1...2 <*> 4...5 <+> 10...11 <*> 40...41
        let expected = [(1,4),(1,5),(2,4),(2,5),(10,40),(10,41),(11,40),(11,41)]
        XCTAssertTrue(equal(expected, actual))
    }
    
    static var allTests : [(String, (CrossProductSequenceTests) -> () throws -> Void)] {
        return [
            ("testCrossProducOfTwoArrays", testCrossProducOfTwoArrays),
            ("testConcatOperatorHasHigherPrecedenceAsCrossProductOperator", testConcatOperatorHasHigherPrecedenceAsCrossProductOperator)
        ]
    }
}
