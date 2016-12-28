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

public struct DateIterator: IteratorProtocol {
    public typealias Element = Date
    
    public init(start: Date, end: Date, matching: DateComponents, matchingPolicy: Calendar.MatchingPolicy, calendar: Calendar) {
        self.calendar = calendar
        self.matching = matching
        self.matchingPolicy = matchingPolicy
        self.end = end
        self.current = start
    }
    
    public mutating func next() -> Date? {
        guard let _current = self.current, _current <= end else { return nil }
        self.current = calendar.nextDate(after: _current, matching: matching, matchingPolicy: matchingPolicy)
        
        return _current
    }
    
    private let calendar: Calendar
    private let end: Date
    private let matching: DateComponents
    private let matchingPolicy: Calendar.MatchingPolicy
    private var current: Date?
}

public func dateSequence(
    start: Date,
    end: Date,
    matching: DateComponents,
    matchingPolicy: Calendar.MatchingPolicy = .strict,
    calendar: Calendar = Calendar.current)
    -> AnySequence<Date>
{
    return AnySequence({ DateIterator(start: start, end: end, matching: matching, matchingPolicy: matchingPolicy, calendar: calendar) })
}
