//
//  KanjiJson.swift
//  Kanji100Tests
//
//  Created by Jéssica Trindade on 14/09/20.
//  Copyright © 2020 Jéssica Trindade. All rights reserved.
//

import Foundation

struct KanjiJson {
    static let json = """
{
    "kanjis": [
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
