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

class ClusterToolsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testIfAnEmptySequenceWillProduceNoCluster() {
        let input: [Int] = []
        let clusters = simpleClustering(sequence: input, similarity: { (a, b) in a == b })

        XCTAssertTrue(clusters.isEmpty)
    }

    func testIfIntegersCanBeClusteredByTheirRightMostDigit() {
        let input = [22, 102, 44, 23, 86, 34, 34]
        let clusters = simpleClustering(sequence: input, similarity: { (a, b) in a % 10 == b % 10 })
        let expectedResult = [[22, 102], [44, 34, 34], [23], [86]]
        
        XCTAssertEqual(expectedResult.count, clusters.count)
        for (expected, actual) in zip(expectedResult, clusters) {
            XCTAssertEqual(expected, actual)
        }
    }

    func testIfThinOutCanRemoveEvenIntegers() {
        let input = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
        let similarity = { (a: Int, b: Int)->Bool in abs(a-b) <= 1 }
        let thinned = thinOut(sequence: input, similarity: similarity)
        
        XCTAssertEqual(input.filter { $0 % 2 == 1 }, thinned)
    }
    
    static var allTests : [(String, (ClusterToolsTests) -> () throws -> Void)] {
        return [
            ("testIfAnEmptySequenceWillProduceNoCluster", testIfAnEmptySequenceWillProduceNoCluster),
            ("testIfIntegersCanBeClusteredByTheirRightMostDigit", testIfIntegersCanBeClusteredByTheirRightMostDigit),
            ("testIfThinOutCanRemoveEvenIntegers", testIfThinOutCanRemoveEvenIntegers)
        ]
    }
}
