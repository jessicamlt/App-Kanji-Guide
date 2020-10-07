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
    static func favoritedKanjisReport (kanji: KanjiData) {
        Analytics.logEvent("favoritedKanjis", parameters: ["id": kanji.id, "kanji": kanji.kanji])
    }
    
    static func unfavoritedKanjiReport(kanji: KanjiData) {
        Analytics.logEvent("unfavoritedKanjis", parameters: ["id": kanji.id, "kanji": kanji.kanji])
    }
}
