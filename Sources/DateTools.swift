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
public enum TimelineGranularity {
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
            return Set<Calendar.Component>(arrayLiteral: .year)
        }
    }
    
    var coarser: TimelineGranularity? {
        switch self {
        case .seconds:
            return .minutes
        case .minutes:
            return .hours
        case .hours:
            return .days
        case .days:
            return .months
        case .months:
            return .years
        case .years:
            return nil
        }
    }
}

@available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
public struct Timeline {
    public init(granularity: TimelineGranularity, calendar: Calendar = Calendar.current) {
        self.calendar = calendar
        self.granularity = granularity
    }

    public func dateInterval(for date: Date) -> DateInterval? {
        return calendar.dateInterval(of: granularity.calendarComponent, for: date)
    }
    
    public func date(after date: Date, first: Int, increment: Int) -> Date? {
        guard let normalizedDate = dateInterval(for: date)?.end else { return nil }
        
        let component = granularity.calendarComponent
        let value = calendar.component(component, from: normalizedDate)
        
        if value < first {
            return calendar.date(bySetting: component, value: first, of: normalizedDate)!
        }
        else {
            let nextValue = smallestValue(divisibleBy: increment, largerThanOrEqualTo: value - first) + first
            
            if let nextDate = calendar.date(bySetting: component, value: nextValue, of: normalizedDate) {
                return nextDate
            }
            else {
                guard let coarserComponent = granularity.coarser?.calendarComponent else { return nil }
                guard let nextStart = calendar.dateInterval(of: coarserComponent, for: date)?.end else { return nil }
                return calendar.date(bySetting: component, value: first, of: nextStart)
            }
        }
    }
    
    private let calendar: Calendar
    private let granularity: TimelineGranularity
}
