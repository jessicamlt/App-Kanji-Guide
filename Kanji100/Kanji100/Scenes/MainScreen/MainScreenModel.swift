//
//  MainScreenModel.swift
//  Kanji100
//
//  Created by Jéssica Trindade on 24/09/20.
//  Copyright © 2020 Jéssica Trindade. All rights reserved.
//

import Foundation

class MainScreenModel {
    let favoriteManager: FavoriteManager
    let repository:KanjisRepository
    
    init(favoriteManager: FavoriteManager, repository: KanjisRepository = KanjisRepository()) {
        self.favoriteManager = favoriteManager
        self.repository = repository
    }
    
    func getKanjis(searchedWord: String) -> [KanjiData] {
        let kanjis = repository
            .getKanjis()
            .kanjiList
            .map { KanjiData(kanji: $0, isFavorite: favoriteManager.contains(id: $0.id))}
        
        if searchedWord.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return kanjis
        }
        
        let filteredKanjis = kanjis.filter { (kanji) -> Bool in
            return kanji.hasWord(searchedWord)
        }
        return filteredKanjis
    }
    
    func saveFavorite(id: Int) {
        favoriteManager.saveFavorite(id: id)
    }
    
    func removeFavorite(id: Int) {
        favoriteManager.removeFavorite(id: id)
    }
}
