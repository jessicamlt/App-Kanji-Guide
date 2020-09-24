//
//  WordsFilter.swift
//  Kanji100
//
//  Created by Jéssica Trindade on 17/09/20.
//  Copyright © 2020 Jéssica Trindade. All rights reserved.
//

import Foundation

struct WordsFilter {
    let kanjis: Kanjis
    
    init(kanjis: Kanjis) {
        self.kanjis = kanjis
    }
    
    func filter(searchedWord: String) -> [Kanji] {
        if searchedWord.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return kanjis.kanjiList
        }
        let filteredKanjis = kanjis.kanjiList.filter { (kanji) -> Bool in
            return kanji.hasWord(searchedWord)
        }
        return filteredKanjis
    }
}
