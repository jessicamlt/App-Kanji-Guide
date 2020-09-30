import XCTest
@testable import Kanji100

class WordsFilterTests: XCTestCase {


    func testFilterWordsElement1() throws {
        let kanjis = KanjiJson.objects

        let filter = WordsFilter(kanjis: kanjis)
        
        XCTAssertEqual(filter.filter(searchedWord: "ichi").count, 1)
        XCTAssertEqual(filter.filter(searchedWord: "ichi").first?.kanji, "一")
        XCTAssertEqual(filter.filter(searchedWord: "一人").first?.kanji, "一")
    }
    
    func testFilterWordsElement2() throws {
        let kanjis = KanjiJson.objects

        let filter = WordsFilter(kanjis: kanjis)
        
        XCTAssertEqual(filter.filter(searchedWord: "ni").count, 1)
        XCTAssertEqual(filter.filter(searchedWord: "ni").first?.kanji, "二")
        XCTAssertEqual(filter.filter(searchedWord: "futa").first?.kanji, "二")
    }
    
    func testFilterWordsAllElements() throws {
        let kanjis = KanjiJson.objects

        let filter = WordsFilter(kanjis: kanjis)
        
        XCTAssertEqual(filter.filter(searchedWord: "numbers").count, 2)
        XCTAssertEqual((filter.filter(searchedWord: "numbers")).first?.kanji, "一")
        XCTAssertEqual((filter.filter(searchedWord: "numbers")).last?.kanji, "二")
    }
    
    func testFilterWordsNoElements() throws {
        let kanjis = KanjiJson.objects

        let filter = WordsFilter(kanjis: kanjis)
        
        XCTAssertEqual(filter.filter(searchedWord: "Four").count, 0)
    }

}
