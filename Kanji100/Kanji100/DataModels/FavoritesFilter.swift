//
//  FavoritesFilter.swift
//  Kanji100
//
//  Created by Jéssica Trindade on 21/09/20.
//  Copyright © 2020 Jéssica Trindade. All rights reserved.
//

import Foundation

struct FavoritesFilter {
    let kanjis: Kanjis
    let favoritesList: [Int]
    
    init(kanjis: Kanjis, favoritesList: [Int]) {
        self.kanjis = kanjis
        self.favoritesList = favoritesList
    }
    
    func filter() -> [Kanji] {
        if favoritesList.isEmpty {
            return []
        }
        
        let favoritesKanjis = kanjis.kanjiList.filter { (kanji) -> Bool in
            return favoritesList.contains(kanji.id)
        }
        return favoritesKanjis
    }
    
    func reloadFilter() -> [Kanji] {
        let favoriteKanjis = kanjis.kanjiList.filter { (kanji) -> Bool in
            return favoritesList.contains(kanji.id)
        }
        return favoriteKanjis
    }
}
