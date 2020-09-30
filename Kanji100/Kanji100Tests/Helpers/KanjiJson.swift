//
//  KanjiJson.swift
//  Kanji100Tests
//
//  Created by Jéssica Trindade on 14/09/20.
//  Copyright © 2020 Jéssica Trindade. All rights reserved.
//

import Foundation
@testable import Kanji100
import XCTest

struct KanjiJson {
    static var objects: Kanjis {
        let json = KanjiJson.json
        let data = Data(json.utf8)
        
        let decoder = JSONDecoder()
        guard let kanjis = try? decoder.decode(Kanjis.self, from: data) else {
            XCTFail("Erro ao transformar Data em JSON")
            fatalError()
        }
        
        return kanjis
    }
    
    static let json = """
{
    "kanjiList": [
        {
            "kanji": "一",
            "englishMeanings": [
                "One"
            ],
            "onyomy": [
                "ichi",
                "itsu"
            ],
            "kunyomi": [
                "hito(tsu)",
                "hito"
            ],
            "category": "Numbers",
            "examples": [{
                "word": "一人",
                "englishMeanings": [
                    "one person",
                    "alone"
                ]
            }]
        },
        {
            "kanji": "二",
            "englishMeanings": [
                "Two"
            ],
            "onyomy": [
                "ni"
            ],
            "kunyomi": [
                "futa(tsu)",
                "futa"
            ],
            "category": "Numbers",
            "examples": [{
                "word": "二人",
                "englishMeanings": [
                    "two people",
                    "pair"
                ]
            }]
        }
    ]
}
"""
}
