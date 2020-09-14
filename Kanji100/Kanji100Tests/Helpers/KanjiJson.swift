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
            "kanji": "a",
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
                "word": "teste1",
                "englishMeanings": [
                    "one person",
                    "alone"
                ]
            }]
        },
        {
            "kanji": "b",
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
                "word": "teste2",
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
