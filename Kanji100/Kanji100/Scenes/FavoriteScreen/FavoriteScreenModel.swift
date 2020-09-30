import Foundation

class FavoriteScreenModel {
    let favoriteManager: FavoriteManager
    let repository: KanjisRepository
    
    init(favoriteManager: FavoriteManager, repository: KanjisRepository = KanjisRepository()) {
        self.favoriteManager = favoriteManager
        self.repository = repository
    }
    
    func getFavoritesKanjis() -> [KanjiData] {
        let kanjis = repository.getKanjis()
        let favoritesIds = favoriteManager.list
        if favoritesIds.isEmpty {
            return []
        }
        let favoritesKanjis = kanjis.kanjiList.filter { (kanji) -> Bool in
            return favoritesIds.contains(kanji.id)
        }.map { KanjiData(kanji: $0, isFavorite: true)}
        
        return favoritesKanjis
    }
    
    func saveFavorite(id: Int) {
        favoriteManager.saveFavorite(id: id)
    }
    
    func removeFavorite(id: Int) {
        favoriteManager.removeFavorite(id: id)
    }
}
