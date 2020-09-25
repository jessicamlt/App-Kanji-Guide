//
//  FavoriteScreenModel.swift
//  Kanji100
//
//  Created by Jéssica Trindade on 24/09/20.
//  Copyright © 2020 Jéssica Trindade. All rights reserved.
//

import Foundation

class FavoriteScreenModel {
    let favoriteManager: FavoriteManager
    let repository: KanjisRepository
    
    init(favoriteManager: FavoriteManager, repository: KanjisRepository = KanjisRepository()) {
        self.favoriteManager = favoriteManager
        self.repository = repository
    }
    
    func getFavoritesKanjis() -> [Kanji] {
        let kanjis = repository.getKanjis()
        let favoritesIds = favoriteManager.list
        if favoritesIds.isEmpty {
            return []
        }
        let favoritesKanjis = kanjis.kanjiList.filter { (kanji) -> Bool in
            return favoritesIds.contains(kanji.id)
        }
        return favoritesKanjis
    }
}
