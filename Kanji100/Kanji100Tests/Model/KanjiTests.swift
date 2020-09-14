//
//  KanjiTests.swift
//  Kanji100Tests
//
//  Created by Jéssica Trindade on 14/09/20.
//  Copyright © 2020 Jéssica Trindade. All rights reserved.
//

import XCTest
@testable import Kanji100

class KanjiTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let json = KanjiJson.json
        let data = Data(json.utf8)
        
        let decoder = JSONDecoder()
        guard let kanjis = try? decoder.decode(Kanjis.self, from: data) else {
            XCTFail("Erro ao transformar Data em JSON")
            return
        }
        print(kanjis)
        
        guard let kanji1 = kanjis.kanjis.first else {
            XCTFail("Erro ao tentar localizar o primeiro Kanji do Array")
            return
        }
        

        XCTAssertEqual(kanjis.kanjis.count , 2)
        XCTAssertEqual(kanji1.kanji, "a")
        XCTAssertEqual(kanji1.englishMeanings?.count ?? 0, 1)
        XCTAssertEqual(kanji1.englishMeanings?[0] ?? "", "One")
        XCTAssertEqual(kanji1.onyomy?.count ?? 0, 2)
        XCTAssertEqual(kanji1.onyomy?[0] ?? "", "ichi")
        XCTAssertEqual(kanji1.onyomy?[1] ?? "", "itsu")
        XCTAssertEqual(kanji1.kunyomi?.count ?? 0, 2)
        XCTAssertEqual(kanji1.kunyomi?[0] ?? "", "hito(tsu)")
        XCTAssertEqual(kanji1.kunyomi?[1] ?? "", "hito")
        XCTAssertEqual(kanji1.category, "Numbers")
        XCTAssertEqual(kanji1.examples?.count ?? 0, 1)
        XCTAssertEqual(kanji1.examples?[0].word ?? "", "teste1")
        XCTAssertEqual(kanji1.examples?[0].englishMeanings?.count ?? 0, 2)
        XCTAssertEqual(kanji1.examples?[0].englishMeanings?[0] ?? "", "one person")
        XCTAssertEqual(kanji1.examples?[0].englishMeanings?[1] ?? "", "alone")
        

     
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
