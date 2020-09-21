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
    
    func saveFavorite(id: Int) {
        var idsCollection = (userDefaults.array(forKey: "ids") as? [Int]) ?? []
        idsCollection.append(id)
        userDefaults.set(idsCollection, forKey: "ids")
    }
    
    func removeFavorite(id: Int) {
        var idsCollection = (userDefaults.array(forKey: "ids") as? [Int]) ?? []
        idsCollection = idsCollection.filter({ (number) -> Bool in
            return number != id
        })
        userDefaults.set(idsCollection, forKey: "ids")
    }
}
