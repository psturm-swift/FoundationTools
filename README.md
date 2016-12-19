# FoundationTools
FoundationTools is a collection of helper classes and functions defined on the Swift Foundation Framework.

## Sequences
Foundation Tools provide the following functions:

1.  `digitsOf<T: Integer>(_ n: T) -> DigitSequence<T> `: The function converts an integer `n` into a sequence of its digits (right to left). The sequence is lazy that means the single digits are computed during iteration.
2. `concat<S: Sequence, T: Sequence>(_ s: S, _ t: T) -> ConcatSequence<S, T>`: The function concatenates two sequences `s` and `t`. The elements of both sequences needs to be of the same type. The result sequence is a lazy sequence. Operator `<+>` can be used instead of `concat`.
3. `crossProduct<S: Sequence, T: Sequence>(_ s: S, _ t: T) -> CrossProductSequence<S, T>`: The function computes the cross product of two sequences. Therefore the function combines each element of sequence `s` and each element of sequence `t` into an tuple. The resulting sequence consists of `|s| * |t|` elements. Operator `<*>` can be used instead of `crossProduct`.
