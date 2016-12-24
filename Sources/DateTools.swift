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

@available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
public enum Timeline {
    case seconds
    case minutes
    case hours
    case days
    case months
    case years
    
    var calendarComponent: Calendar.Component {
        switch self {
        case .seconds:
            return .second
        case .minutes:
            return .minute
        case .hours:
            return .hour
        case .days:
            return .day
        case .months:
            return .month
        case .years:
            return .year
        }
    }
    
    var calendarComponents: Set<Calendar.Component> {
        switch self {
        case .seconds:
            return Set<Calendar.Component>(arrayLiteral: .second, .minute, .hour, .day, .month, .year)
        case .minutes:
            return Set<Calendar.Component>(arrayLiteral: .minute, .hour, .day, .month, .year)
        case .hours:
            return Set<Calendar.Component>(arrayLiteral: .hour, .day, .month, .year)
        case .days:
            return Set<Calendar.Component>(arrayLiteral: .day, .month, .year)
        case .months:
            return Set<Calendar.Component>(arrayLiteral: .month, .year)
        case .years:
            return  Set<Calendar.Component>(arrayLiteral: .year)
        }
    }
    
    public func dateInterval(for date: Date) -> DateInterval {
        let components = Calendar.current.dateComponents(self.calendarComponents, from: date)
        let start = Calendar.current.date(from: components)!
        let end = Calendar.current.date(byAdding: self.calendarComponent, value: 1, to: start)!
        
        return DateInterval(start: start, end: end)
    }
    
    public func closestDate(for date: Date) -> Date {
        let interval = self.dateInterval(for: date)
        let start = interval.start.timeIntervalSince1970
        let end = interval.end.timeIntervalSince1970
        let value = date.timeIntervalSince1970
        
        return value - start <= end - value ? interval.start : interval.end
    }
}

