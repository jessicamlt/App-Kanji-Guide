//
//  Kanji.swift
//  Kanji100
//
//  Created by Jéssica Trindade on 17/09/20.
//  Copyright © 2020 Jéssica Trindade. All rights reserved.
//

import Foundation

struct Kanji: Decodable {
    var kanji: String
    var englishMeanings: [String]
    var onyomy: [String]
    var kunyomi: [String]
    var category: String
    var examples: [Word]
    
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
