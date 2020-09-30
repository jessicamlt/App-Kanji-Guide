import XCTest
@testable import Kanji100

class WordTests: XCTestCase {
    
    func testHasWord() throws {
        let word = Word(word: "Feira",
                        englishMeanings: ["Banana", "abacaxi", "UVA"])

        XCTAssertTrue(word.hasWord("Feira"))
        XCTAssertTrue(word.hasWord("BANANA"))
        XCTAssertTrue(word.hasWord("Abacaxi"))
        XCTAssertTrue(word.hasWord("uva"))
        XCTAssertFalse(word.hasWord("fei"))
    }
}

