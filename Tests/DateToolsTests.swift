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

class DateToolsTests: XCTestCase {
    
    func date(fromString dateAsString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ";
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        return dateFormatter.date(from: dateAsString)!
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTimelineInMinutesForDateWithinInterval() {
        let date = self.date(fromString: "2016-12-23T20:09:56+00:00")
        let dateInterval = Timeline.minutes.dateInterval(for: date)
        let closestDate = Timeline.minutes.closestDate(for: date)
        
        XCTAssertEqual(self.date(fromString: "2016-12-23T20:09:00+00:00"), dateInterval.start)
        XCTAssertEqual(self.date(fromString: "2016-12-23T20:10:00+00:00"), dateInterval.end)
        XCTAssertEqual(dateInterval.end, closestDate)
    }

    func testTimelineInMinutesForDateOnIntervalBound() {
        let date = self.date(fromString: "2016-12-23T20:09:00+00:00")
        let dateInterval = Timeline.minutes.dateInterval(for: date)
        let closestDate = Timeline.minutes.closestDate(for: date)
        
        XCTAssertEqual(self.date(fromString: "2016-12-23T20:09:00+00:00"), dateInterval.start)
        XCTAssertEqual(self.date(fromString: "2016-12-23T20:10:00+00:00"), dateInterval.end)
        XCTAssertEqual(dateInterval.start, closestDate)
    }

    func testTimelineInHoursForDateWithinInterval() {
        let date = self.date(fromString: "2016-12-23T20:09:56+00:00")
        let dateInterval = Timeline.hours.dateInterval(for: date)
        let closestDate = Timeline.hours.closestDate(for: date)
        
        XCTAssertEqual(self.date(fromString: "2016-12-23T20:00:00+00:00"), dateInterval.start)
        XCTAssertEqual(self.date(fromString: "2016-12-23T21:00:00+00:00"), dateInterval.end)
        XCTAssertEqual(dateInterval.start, closestDate)
    }
    
    func testTimelineInHoursForDateOnIntervalBound() {
        let date = self.date(fromString: "2016-12-23T20:09:00+00:00")
        let dateInterval = Timeline.hours.dateInterval(for: date)
        let closestDate = Timeline.hours.closestDate(for: date)
        
        XCTAssertEqual(self.date(fromString: "2016-12-23T20:00:00+00:00"), dateInterval.start)
        XCTAssertEqual(self.date(fromString: "2016-12-23T21:00:00+00:00"), dateInterval.end)
        XCTAssertEqual(dateInterval.start, closestDate)
    }
}
