//
//  MainScreenModel.swift
//  Kanji100
//
//  Created by Jéssica Trindade on 24/09/20.
//  Copyright © 2020 Jéssica Trindade. All rights reserved.
//

import Foundation

class MainScreenModel {
    let repository:KanjisRepository
    
    init(repository: KanjisRepository = KanjisRepository()) {
        self.repository = repository
    }
    
    func getKanjis(searchedWord: String) -> [Kanji] {
        let kanjis = repository.getKanjis()
        if searchedWord.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return kanjis.kanjiList
        }
        let filteredKanjis = kanjis.kanjiList.filter { (kanji) -> Bool in
            return kanji.hasWord(searchedWord)
        }
        return filteredKanjis
    }
}
