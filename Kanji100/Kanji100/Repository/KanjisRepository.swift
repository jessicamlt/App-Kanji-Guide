//
//  KanjisModel.swift
//  Kanji100
//
//  Created by Jéssica Trindade on 14/09/20.
//  Copyright © 2020 Jéssica Trindade. All rights reserved.
//

import Foundation

class KanjisRepository {
    func getData() -> Data {
        guard let url = Bundle.main.url(forResource: "jlptn5Kanjis.json", withExtension: nil) else {
            fatalError("File not found")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Fail to get data")
        }
        return data
    }
    
    func convertJSON() -> Kanjis {
        do {
            let data = getData()
            let decoder = JSONDecoder()
            let kanjis = try decoder.decode(Kanjis.self, from: data)
            return kanjis
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
