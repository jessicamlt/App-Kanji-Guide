import XCTest
@testable import Kanji100

class WordTests: XCTestCase {
    
    func testHasWord() throws {
        let word = Word(word: "Jessica",
                        englishMeanings: ["Maria", "lino", "TRINDADE"])

        XCTAssertTrue(word.hasWord("Jessica"))
        XCTAssertTrue(word.hasWord("LINO"))
        XCTAssertTrue(word.hasWord("trindade"))
        XCTAssertTrue(word.hasWord("jessica"))
        XCTAssertFalse(word.hasWord("Santos"))
    }

}

