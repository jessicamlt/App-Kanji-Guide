import Foundation

struct Kanji: Decodable {
    var id: Int
    var kanji: String
    var englishMeanings: [String]
    var onyomi: [String]
    var kunyomi: [String]
    var category: String
    var examples: [Word]
}
