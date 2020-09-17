//
//  WordTests.swift
//  Kanji100Tests
//
//  Created by Jéssica Trindade on 17/09/20.
//  Copyright © 2020 Jéssica Trindade. All rights reserved.
//

import XCTest
@testable import Kanji100

class WordTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testHasWord() throws {
        let word = Word(word: "Jessica",
                        englishMeanings: ["Maria", "lino", "TRINDADE"])

        XCTAssertTrue(word.hasWord("Jessica"))
        XCTAssertTrue(word.hasWord("LINO"))
        XCTAssertTrue(word.hasWord("trindade"))
        XCTAssertTrue(word.hasWord("jessica"))
        XCTAssertFalse(word.hasWord("Santos"))
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

