import XCTest
@testable import FoundationToolsTests

XCTMain([
     testCase(ConcatSequencesTests.allTests),
     testCase(CrossProductSequenceTests.allTests),
     testCase(DateToolsTests.allTests),
     testCase(DigitsTests.allTests),
     testCase(OptionalToolsTests.allTests),
     testCase(DictionaryToolsTests.allTests)
])
