//
//  BoxJeonExtensionTests.swift
//  BoxJeonExtensionTests
//
//  Created by boxjeon on 2017. 10. 21..
//  Copyright © 2017년 boxjeon. All rights reserved.
//

import XCTest
@testable import BoxJeonExtension

class BoxJeonExtensionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testURL() {
        let url = "http://book.daum.net/search/bookSearch.do?advancedSearchYN=y&amp;publisher=글담출판사&amp;sortType=0&amp;searchType=publisher"
        let result = URL.safeVersion(from: url)
        XCTAssertEqual(result?.query, "advancedSearchYN=y&publisher=%EA%B8%80%EB%8B%B4%EC%B6%9C%ED%8C%90%EC%82%AC&sortType=0&searchType=publisher")
    }
    
    func testURLPerformance() {
        self.measure {
            let url = "http://book.daum.net/search/bookSearch.do?advancedSearchYN=y&amp;publisher=글담출판사&amp;sortType=0&amp;searchType=publisher"
            _ = URL.safeVersion(from: url)
        }
    }
}
