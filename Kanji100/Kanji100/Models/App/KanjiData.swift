//
//  Kanji.swift
//  Kanji100
//
//  Created by Jéssica Trindade on 17/09/20.
//  Copyright © 2020 Jéssica Trindade. All rights reserved.
//

import Foundation

struct KanjiData: Decodable {
    var id: Int
    var kanji: String
    var englishMeanings: [String]
    var onyomy: [String]
    var kunyomi: [String]
    var category: String
    var examples: [Word]
    var isFavorite: Bool
    
    init(kanji: Kanji, isFavorite: Bool) {
        self.id = kanji.id
        self.kanji = kanji.kanji
        self.englishMeanings = kanji.englishMeanings
        self.onyomy = kanji.kunyomi
        self.kunyomi = kanji.kunyomi
        self.category = kanji.category
        self.examples = kanji.examples
        self.isFavorite = isFavorite
    }
    
    func hasWord(_ word: String) -> Bool{
        let lowerWord = word.lowercased()
        return kanji.lowercased().contains(lowerWord) ||
            englishMeanings.joined(separator: " ").lowercased().contains(lowerWord) ||
            onyomy.joined(separator: " ").lowercased().contains(lowerWord) ||
            kunyomi.joined(separator: " ").lowercased().contains(lowerWord) ||
            category.lowercased().contains(lowerWord) ||
            !(examples.filter { $0.hasWord(lowerWord) }.isEmpty)
    }
}