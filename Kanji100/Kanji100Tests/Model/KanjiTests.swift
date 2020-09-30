import XCTest
@testable import Kanji100

class KanjiTests: XCTestCase {

    func testKanjiEncoding() throws {
        let kanjis = KanjiJson.objects
        
        guard let kanji1 = kanjis.kanjiList.first else {
            XCTFail("Erro ao tentar localizar o primeiro Kanji do Array")
            return
        }
        
        XCTAssertEqual(kanjis.kanjiList.count , 2)
        XCTAssertEqual(kanji1.kanji, "一")
        XCTAssertEqual(kanji1.englishMeanings.count, 1)
        XCTAssertEqual(kanji1.englishMeanings[0], "One")
        XCTAssertEqual(kanji1.onyomi.count, 2)
        XCTAssertEqual(kanji1.onyomi[0], "ichi")
        XCTAssertEqual(kanji1.onyomi[1], "itsu")
        XCTAssertEqual(kanji1.kunyomi.count, 2)
        XCTAssertEqual(kanji1.kunyomi[0], "hito(tsu)")
        XCTAssertEqual(kanji1.kunyomi[1], "hito")
        XCTAssertEqual(kanji1.category, "Numbers")
        XCTAssertEqual(kanji1.examples.count, 1)
        XCTAssertEqual(kanji1.examples[0].word, "一人")
        XCTAssertEqual(kanji1.examples[0].englishMeanings.count, 2)
        XCTAssertEqual(kanji1.examples[0].englishMeanings[0], "one person")
        XCTAssertEqual(kanji1.examples[0].englishMeanings[1], "alone")
        
    }
    
    func testHasKanji() throws {
        let repository = KanjisRepository()
        let favoriteManager = FavoriteManager()
        let kanji = repository
            .getKanjis()
            .kanjiList
            .map { KanjiData(kanji: $0, isFavorite: favoriteManager.contains(id: $0.id))}.first!
        XCTAssertTrue(kanji.hasWord("ichi"))
        XCTAssertTrue(kanji.hasWord("ich"))
        XCTAssertTrue(kanji.hasWord("Ich"))
        XCTAssertTrue(kanji.hasWord("person"))
        XCTAssertTrue(kanji.hasWord("Person"))
        XCTAssertTrue(kanji.hasWord("hito(tsu)"))
        XCTAssertTrue(kanji.hasWord("一"))
        XCTAssertTrue(kanji.hasWord("一人"))
        XCTAssertTrue(kanji.hasWord("Alone"))
        XCTAssertTrue(kanji.hasWord("numbers"))
        XCTAssertTrue(kanji.hasWord("num"))
        XCTAssertTrue(kanji.hasWord("Num"))
        XCTAssertFalse(kanji.hasWord("three"))
        XCTAssertFalse(kanji.hasWord("thing"))
        XCTAssertFalse(kanji.hasWord("二"))
        XCTAssertFalse(kanji.hasWord("Hitori"))
    }
    
}
