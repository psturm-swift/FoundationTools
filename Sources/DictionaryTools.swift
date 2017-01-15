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

public func buildDictionary<K : Hashable, V, S: Sequence>(from sequence: S) -> [K:V] where S.Iterator.Element == (K, V) {
    var dictionary: [K:V] = [:]
    
    for (key, value) in sequence {
        dictionary.updateValue(value, forKey: key)
    }
    
    return dictionary
}

fileprivate func _map<K: Hashable, Vs, Vt>(dictionary: [K:Vs], transform: (Vs) throws -> (Vt)) rethrows -> [K:Vt] {
    return buildDictionary(from: try dictionary.lazy.map { ($0.0, try transform($0.1)) })
}

fileprivate func _map<Ks : Hashable, Vs, Kt : Hashable, Vt>(dictionary: [Ks:Vs], transform: (Ks, Vs) throws -> (Kt, Vt)) rethrows -> [Kt:Vt] {
    return buildDictionary(from: try dictionary.lazy.map { item in try transform(item.0, item.1) })
}

public func map<Ks : Hashable, Vs, Kt : Hashable, Vt>(dictionary: [Ks:Vs], transform: (Ks, Vs) throws -> (Kt, Vt)) rethrows -> [Kt:Vt] {
    return try _map(dictionary: dictionary, transform: transform)
}

public func invert<K : Hashable, V: Hashable>(dictionary: [K:V]) -> [V:K] {
    return map(dictionary: dictionary) { (key, value) in (value, key) }
}

public extension Dictionary where Value: Hashable {
    func mapDictionary<KeyT: Hashable, ValueT>(_ transform: (Key, Value) throws -> (KeyT, ValueT)) rethrows -> [KeyT:ValueT] {
        return try _map(dictionary: self, transform: transform)
    }
    
    func inverted() -> [Value:Key] {
        return invert(dictionary: self)
    }
}
