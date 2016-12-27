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

public struct PeriodicIterator<S: Sequence>: IteratorProtocol {
    public typealias Element = S.Iterator.Element

    public init(base: S) {
        self.makeIterator = { base.makeIterator() }
        self.currentIterator = makeIterator()
    }
    
    public mutating func next() -> S.Iterator.Element? {
        if let nextElement = currentIterator.next() {
            return nextElement
        }
        else {
            currentIterator = makeIterator()
            guard let nextElement = currentIterator.next() else { return nil }
            return nextElement
        }
    }
    
    private var currentIterator: S.Iterator
    private let makeIterator: ()->S.Iterator
}

public func periodicSequence<S: Sequence>(base: S) -> AnySequence<S.Iterator.Element> {
    return AnySequence({ PeriodicIterator(base: base) })
}

public func periodicSequence<T>(arrayLiteral elements: T...) -> AnySequence<T> {
    return AnySequence({ PeriodicIterator(base: elements) })
}
