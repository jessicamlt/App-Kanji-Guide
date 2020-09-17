import Foundation

struct Word: Decodable {
    var word: String
    var englishMeanings: [String]
    
    var examples: String {
        let meanings = englishMeanings
        return "\(word) (\(meanings.joined(separator: " / ")))"
    }
    
    func hasWord(_ word: String) -> Bool {
        let lowerWord = word.lowercased()
        return examples.lowercased().contains(lowerWord)
    }

}
