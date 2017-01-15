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

class DateSequenceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testDateSequenceOnDayWithDaylightSaving() {
        guard let start = dateFormatter.date(from: "2017-03-26 00:00:00") else { XCTAssertTrue(false); return}
        guard let end = dateFormatter.date(from: "2017-03-26 12:00:00") else { XCTAssertTrue(false); return}
        
        
        let expected = [
            "2017-03-26 00:00:00",
            "2017-03-26 04:00:00",
            "2017-03-26 06:00:00",
            "2017-03-26 08:00:00",
            "2017-03-26 10:00:00",
            "2017-03-26 12:00:00"
        ]
        
        let actual =
            dateSequence(start: start, end: end, matching: DateComponents(minute: 0), calendar: self.calendar)
            .filter { calendar.component(.hour, from: $0) % 2 == 0 }
            .map { dateFormatter.string(from: $0) }

        XCTAssertEqual(expected, actual)
    }
    
    let calendar: Calendar = { () -> Calendar in
        var calendar = Calendar(identifier: .gregorian)
        if let timeZone = TimeZone(identifier: "Europe/Berlin") {
            calendar.timeZone = timeZone
        }
        else {
            fatalError("Cannot set timezone 'Europe/Berlin'")
        }
        return calendar
    }()
    lazy var dateFormatter: DateFormatter = { () -> DateFormatter in
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss";
        dateFormatter.timeZone = self.calendar.timeZone
        dateFormatter.locale = self.calendar.locale!
        return dateFormatter
    }()

    static var allTests : [(String, (DateSequenceTests) -> () throws -> Void)] {
        return [
            ("testDateSequenceOnDayWithDaylightSaving", testDateSequenceOnDayWithDaylightSaving)
        ]
    }
}
