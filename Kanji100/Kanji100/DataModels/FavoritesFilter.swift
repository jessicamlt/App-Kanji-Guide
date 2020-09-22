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
    
    init(kanjis: Kanjis) {
        self.kanjis = kanjis
    }
    
    func filter(favoritesList: [Int]) -> [Kanji] {
        if favoritesList.isEmpty {
            return []
        }
        
        let favoritesKanjis = kanjis.kanjiList.filter { (kanji) -> Bool in
            return favoritesList.contains(kanji.id)
        }
        return favoritesKanjis
    }
    
}
