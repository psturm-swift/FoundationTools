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

public func dictionaryMap<Ks : Hashable, Vs, Kt : Hashable, Vt>(_ dictionary: [Ks:Vs], transform: (Ks, Vs) -> (Kt, Vt)) -> [Kt:Vt] {
    var result: [Kt:Vt] = [:]
    for (key, value) in dictionary {
        let (keyTransformed, valueTransformed) = transform(key, value)
        result.updateValue(valueTransformed, forKey: keyTransformed)
    }
    return result
}

public func dictionaryMap<Ks : Hashable, Vs, Kt : Hashable, Vt>(_ dictionary: [Ks:Vs], transform: (Ks, Vs) throws -> (Kt, Vt)) throws -> [Kt:Vt] {
    var result: [Kt:Vt] = [:]
    for (key, value) in dictionary {
        let (keyTransformed, valueTransformed) = try transform(key, value)
        result.updateValue(valueTransformed, forKey: keyTransformed)
    }
    return result
}

public func dictionaryInverted<K : Hashable, V: Hashable>(_ dictionary: [K:V]) -> [V:K] {
    return dictionaryMap(dictionary) { (key, value) in (value, key) }
}

public extension Dictionary {
    func map<K:Hashable, V>(_ transform: (Key, Value)->(K, V)) -> [K:V] {
        return dictionaryMap(self, transform: transform)
    }

    func map<K:Hashable, V>(_ transform: (Key, Value) throws -> (K, V)) throws -> [K:V] {
        return try dictionaryMap(self, transform: transform)
    }
}

public extension Dictionary where Value: Hashable {
    func inverted() -> [Value:Key] {
        return dictionaryInverted(self)
    }
}
