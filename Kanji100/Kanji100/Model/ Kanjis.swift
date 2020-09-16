//
//   Kanji.swift
//  Kanji100
//
//  Created by Jéssica Trindade on 14/09/20.
//  Copyright © 2020 Jéssica Trindade. All rights reserved.
//

import Foundation

struct Kanjis: Decodable {
    var kanjiList: [Kanji]
}

struct Kanji: Decodable {
    var kanji: String
    var englishMeanings: [String]
    var onyomy: [String]
    var kunyomi: [String]
    var category: String
    var examples: [Word]
    
    func hasWord(_ word: String) -> Bool{
        if kanji.contains(word) {
            return true
        } else if (englishMeanings.joined(separator: " ")).contains(word) {
            return true
        } else if (onyomy.joined(separator: " ")).contains(word) {
            return true
        } else if (kunyomi.joined(separator: " ")).contains(word) {
            return true
        } else if category.contains(word) {
            return true
        }
        return false
    }
}

struct Word: Decodable {
    var word: String
    var englishMeanings: [String]
    
    var examples: String {
        let meanings = englishMeanings
        return "\(word) (\(meanings.joined(separator: " / ")))"
    }
    
    func hasWord(_ word: String) -> Bool {
        if examples.contains(word) {
            return true
        }
        return false
    }

}

