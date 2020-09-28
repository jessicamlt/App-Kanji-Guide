//
//  Kanji.swift
//  Kanji100
//
//  Created by Jéssica Trindade on 17/09/20.
//  Copyright © 2020 Jéssica Trindade. All rights reserved.
//

import Foundation

struct Kanji: Decodable {
    var id: Int
    var kanji: String
    var englishMeanings: [String]
    var onyomy: [String]
    var kunyomi: [String]
    var category: String
    var examples: [Word]
}
