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

public struct CrossProductIterator<S: Sequence, T: Sequence>: IteratorProtocol {
    public typealias Element = (S.Iterator.Element, T.Iterator.Element)
    
    public init(s: S, t: T) {
        self.currentT = t.makeIterator()
        self.currentS = s.makeIterator()
        self.elementS = currentS.next()
        self.makeIteratorOfT = t.makeIterator
    }
    
    public mutating func next() -> Element? {
        guard let elementS = self.elementS else { return nil }
        if let elementT = self.currentT.next() {
            return (elementS, elementT)
        }
        else {
            self.elementS = self.currentS.next()
            self.currentT = self.makeIteratorOfT()
            
            return next()
        }
    }
    
    let makeIteratorOfT: () -> T.Iterator
    var currentT: T.Iterator
    var currentS: S.Iterator
    var elementS: S.Iterator.Element?
}

public func crossProduct<S: Sequence, T: Sequence>(ofSequences s: S, _ t: T) -> AnySequence<(S.Iterator.Element, T.Iterator.Element)> {
    return AnySequence({ CrossProductIterator(s: s, t: t) })
}
