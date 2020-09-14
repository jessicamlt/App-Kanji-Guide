//
//   Kanji.swift
//  Kanji100
//
//  Created by Jéssica Trindade on 14/09/20.
//  Copyright © 2020 Jéssica Trindade. All rights reserved.
//

import Foundation

struct Kanji: Decodable {
    var kanji: String?
    var englishMeaning: [String]?
    var onyomy: [String]?
    var kunyomi: [String]?
    var category: String?
    var examples: [Word]?
}

struct Word: Decodable {
    var word: String?
    var englishMeaning: [String]?
}
