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

public func concat<S: Sequence, T: Sequence>(sequences s: S, _ t: T) -> AnySequence<S.Iterator.Element>
    where S.Iterator.Element==T.Iterator.Element
{
    let sequences = [AnySequence(s.makeIterator), AnySequence(t.makeIterator)]
    return AnySequence(sequences.lazy.flatMap { $0.lazy.map { $0 } })
}

infix operator <+>: AdditionPrecedence
public func <+><S: Sequence, T: Sequence>(lhs: S, rhs: T) -> AnySequence<S.Iterator.Element>
    where S.Iterator.Element==T.Iterator.Element
{
    return concat(sequences: lhs, rhs)
}
