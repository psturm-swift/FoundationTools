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

import Foundation
import XCTest
@testable import FoundationTools

@available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
class DateToolsTests: XCTestCase {
    
    func date(fromString dateAsString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss";
        dateFormatter.timeZone = Calendar.current.timeZone
        guard let locale = Calendar.current.locale else { return nil }
        dateFormatter.locale = locale
        
        return dateFormatter.date(from: dateAsString)
    }
    
    func dateIntervalFromStrings(start: String, end: String) -> DateInterval? {
        guard let startDate = date(fromString: start) else { return nil }
        guard let endDate = date(fromString: end) else { return nil }
        
        return DateInterval(start: startDate, end: endDate)
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testIfDateAfterWorksProperlyForDateCausingOverflows() {
        guard let endOfYear = date(fromString: "2016-12-31T23:59:59") else {
            XCTAssertTrue(false)
            return
        }
        
        XCTAssertEqual(date(fromString: "2017-01-01T00:00:10"), timelineSeconds.date(after: endOfYear, first: 10, increment: 2))
        XCTAssertEqual(date(fromString: "2017-01-01T00:10:00"), timelineMinutes.date(after: endOfYear, first: 10, increment: 2))
        XCTAssertEqual(date(fromString: "2017-01-01T10:00:00"), timelineHours.date(after: endOfYear, first: 10, increment: 2))
        XCTAssertEqual(date(fromString: "2017-01-10T00:00:00"), timelineDays.date(after: endOfYear, first: 10, increment: 2))
        XCTAssertEqual(date(fromString: "2017-10-01T00:00:00"), timelineMonths.date(after: endOfYear, first: 10, increment: 2))
        XCTAssertEqual(date(fromString: "2018-01-01T00:00:00"), timelineYears.date(after: endOfYear, first: 10, increment: 2))
    }

    func testIfDateAfterWorksProperlyForDatesWithComponentBeforeFirst() {
        guard let testDate = date(fromString: "2016-07-15T14:31:23") else {
            XCTAssertTrue(false)
            return
        }
        
        XCTAssertEqual(date(fromString: "2016-07-15T14:31:25"), timelineSeconds.date(after: testDate, first: 25, increment: 2))
        XCTAssertEqual(date(fromString: "2016-07-15T14:41:00"), timelineMinutes.date(after: testDate, first: 41, increment: 2))
        XCTAssertEqual(date(fromString: "2016-07-15T18:00:00"), timelineHours.date(after: testDate, first: 18, increment: 2))
        XCTAssertEqual(date(fromString: "2016-07-17T00:00:00"), timelineDays.date(after: testDate, first: 17, increment: 2))
        XCTAssertEqual(date(fromString: "2016-11-01T00:00:00"), timelineMonths.date(after: testDate, first: 11, increment: 2))
        XCTAssertEqual(date(fromString: "2019-01-01T00:00:00"), timelineYears.date(after: testDate, first: 2019, increment: 2))
    }

    func testIfDateAfterWorksProperlyForDatesWithComponentEqualToFirst() {
        guard let testDate = date(fromString: "2016-07-15T14:31:23") else {
            XCTAssertTrue(false)
            return
        }
        
        XCTAssertEqual(date(fromString: "2016-07-15T14:31:25"), timelineSeconds.date(after: testDate, first: 23, increment: 2))
        XCTAssertEqual(date(fromString: "2016-07-15T14:33:00"), timelineMinutes.date(after: testDate, first: 31, increment: 2))
        XCTAssertEqual(date(fromString: "2016-07-15T16:00:00"), timelineHours.date(after: testDate, first: 14, increment: 2))
        XCTAssertEqual(date(fromString: "2016-07-17T00:00:00"), timelineDays.date(after: testDate, first: 15, increment: 2))
        XCTAssertEqual(date(fromString: "2016-09-01T00:00:00"), timelineMonths.date(after: testDate, first: 7, increment: 2))
        XCTAssertEqual(date(fromString: "2018-01-01T00:00:00"), timelineYears.date(after: testDate, first: 2016, increment: 2))
    }
    
    func testIfDateAfterWorksProperlyForDatesWithComponentLargerThanFirstWithoutCausingAnOverflow() {
        guard let testDate = date(fromString: "2016-07-15T14:31:23") else {
            XCTAssertTrue(false)
            return
        }
        
        XCTAssertEqual(date(fromString: "2016-07-15T14:31:25"), timelineSeconds.date(after: testDate, first: 3, increment: 2))
        XCTAssertEqual(date(fromString: "2016-07-15T14:33:00"), timelineMinutes.date(after: testDate, first: 3, increment: 2))
        XCTAssertEqual(date(fromString: "2016-07-15T15:00:00"), timelineHours.date(after: testDate, first: 3, increment: 2))
        XCTAssertEqual(date(fromString: "2016-07-17T00:00:00"), timelineDays.date(after: testDate, first: 3, increment: 2))
        XCTAssertEqual(date(fromString: "2016-09-01T00:00:00"), timelineMonths.date(after: testDate, first: 3, increment: 2))
        XCTAssertEqual(date(fromString: "2017-01-01T00:00:00"), timelineYears.date(after: testDate, first: 3, increment: 2))
    }
    

    func testIfDateAfterWorksProperlyForSummerTime() {
        guard let testDateInWinterTime = date(fromString: "2017-03-26T01:31:23") else {
            XCTAssertTrue(false)
            return
        }
        XCTAssertEqual(date(fromString: "2017-03-26T04:00:00"), timelineHours.date(after: testDateInWinterTime, first: 0, increment: 4))
    }

    let timelineSeconds = Timeline(granularity: .seconds)
    let timelineMinutes = Timeline(granularity: .minutes)
    let timelineHours = Timeline(granularity: .hours)
    let timelineDays = Timeline(granularity: .days)
    let timelineMonths = Timeline(granularity: .months)
    let timelineYears = Timeline(granularity: .years)
    
    static var allTests : [(String, (DateToolsTests) -> () throws -> Void)] {
        return [
            ("testIfDateAfterWorksProperlyForDateCausingOverflows", testIfDateAfterWorksProperlyForDateCausingOverflows),
            ("testIfDateAfterWorksProperlyForDatesWithComponentBeforeFirst", testIfDateAfterWorksProperlyForDatesWithComponentBeforeFirst),
            ("testIfDateAfterWorksProperlyForDatesWithComponentEqualToFirst", testIfDateAfterWorksProperlyForDatesWithComponentEqualToFirst),
            ("testIfDateAfterWorksProperlyForDatesWithComponentLargerThanFirstWithoutCausingAnOverflow", testIfDateAfterWorksProperlyForDatesWithComponentLargerThanFirstWithoutCausingAnOverflow),
            ("testIfDateAfterWorksProperlyForSummerTime", testIfDateAfterWorksProperlyForSummerTime)
        ]
    }
}
