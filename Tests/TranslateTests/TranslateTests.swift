import XCTest
@testable import Translate

final class TranslateTests: XCTestCase {
    
    struct IntegerToStringTranslator: TopLevelTranslator {
        
        func translate(from input: Int) -> String {
            return String(input)
        }
    }
    
    func testTranslateIntToString() {
        _ = [1, 2, 3]
            .publisher
            .translate(translator: IntegerToStringTranslator()) // Translate int to string.
            .collect() // collect all elements into a single array.
            .map { $0.reduce("", { $0 + $1 })} // sum all values in the array.
            .sink { (result) in
                XCTAssertEqual(result, "123")
        }
    }
    
    func testTranslateIntCollectionToStringColelction() {
        _ = [[1, 2, 3], [4, 5, 6]]
            .publisher
            .translates(translator: IntegerToStringTranslator())
            .collect()
            .map { $0.flatMap { $0 }.reduce("", { $0 + $1 }) } // sum all values in the array.
            .sink(receiveValue: { (result) in
                XCTAssertEqual(result, "123456")
            })
    }

    static var allTests = [
        ("testExample", testTranslateIntToString),
    ]
}
