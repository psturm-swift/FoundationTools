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

class DictionaryToolsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testIfANoneEmptyDictionaryCanBeMappedIntoDifferentOneByChangingRolesBetweenValueAndKey() {
        let dictionary = [ 1 : "10", 2 : "20", 3 : "30", 4 : "40" ]
        let invertedDictionary = dictionary.map { (key, value) in (value, key) }

        XCTAssertEqual([ "10" : 1, "20" : 2, "30" : 3, "40" : 4 ], invertedDictionary)
    }

    func testIfAnEmptyDictionaryMapsToAnEmptyDictionary() {
        let dictionary: [String: Int] = [:]
        let invertedDictionary = dictionary.map { (key, value) in (value, key) }
        
        XCTAssertEqual(dictionary.isEmpty, invertedDictionary.isEmpty)
    }
    
    static var allTests : [(String, (DictionaryToolsTests) -> () throws -> Void)] {
        return [
            ("testIfANoneEmptyDictionaryCanBeMappedIntoDifferentOneByChangingRolesBetweenValueAndKey", testIfANoneEmptyDictionaryCanBeMappedIntoDifferentOneByChangingRolesBetweenValueAndKey),
            ("testIfAnEmptyDictionaryMapsToAnEmptyDictionary", testIfAnEmptyDictionaryMapsToAnEmptyDictionary)
        ]
    }
}
