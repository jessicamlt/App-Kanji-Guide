//
//  FavoriteManager.swift
//  Kanji100
//
//  Created by Jéssica Trindade on 21/09/20.
//  Copyright © 2020 Jéssica Trindade. All rights reserved.
//

import Foundation

class FavoriteManager {
    let userDefaults = UserDefaults.standard
    
    private(set) var list: [Int] = []
    
    init() {
        loadFavorites()
    }
    
    func saveFavorite(id: Int) {
        loadFavorites()
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
        print(list)
    }
    
    func loadFavorites() {
        let idsCollection = (userDefaults.array(forKey: "ids") as? [Int]) ?? []
        list = idsCollection
    }
    
    func contains(id: Int) -> Bool {
        return list.contains(id)
    }
}
