//
//  Events.swift
//  Kanji100
//
//  Created by Jéssica Trindade on 06/10/20.
//  Copyright © 2020 Jéssica Trindade. All rights reserved.
//

import Foundation
import FirebaseAnalytics

struct Events {
    static func favoritedKanjisReport (id: Int) {
        Analytics.logEvent("favoritedKanjis", parameters: ["id": id])
    }
    
    static func unfavoritedKanjiReport(id: Int) {
        Analytics.logEvent("unfavoritedKanjis", parameters: ["id": id])
    }
}
