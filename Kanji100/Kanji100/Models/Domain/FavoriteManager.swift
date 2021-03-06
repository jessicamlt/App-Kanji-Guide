import Foundation

class FavoriteManager {
    let userDefaults = UserDefaults.standard
    private(set) var list: [Int] = []
    
    var favoritesCount: Int {
        return list.count
    }
    
    init() {
        loadFavorites()
    }
    
    func saveFavorite(id: Int) {
        loadFavorites()
        if list.contains(id) {
            return
        }
        
        list.append(id)
        userDefaults.set(list, forKey: "ids")
        print(list)
    }
    
    func removeFavorite(id: Int) {
        loadFavorites()
        list = list.filter({ (number) -> Bool in
            return number != id
        })
        userDefaults.set(list, forKey: "ids")
    }
    
    private func loadFavorites() {
        let idsCollection = (userDefaults.array(forKey: "ids") as? [Int]) ?? []
        list = idsCollection
    }
    
    func contains(id: Int) -> Bool {
        return list.contains(id)
    }
}
