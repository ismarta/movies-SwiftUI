//
//  AppendApiKeyTests.swift
//  MoviesTests
//
//  Created by Marta on 15/3/24.
//

import XCTest
@testable import Movies

final class AppendApiKeyTests: XCTestCase {
    func testAppendApiKeyInUrlWithoutQueryItems() {
        //GIVEN
        var url = "www.mytests.com"
        let apiKey = "myApiKey"
        //WHEN
        url = url.appendApiKey(apiKey)
        //THEN
        XCTAssertEqual(url, "www.mytests.com?api_key=\(apiKey)")
    }

    func testAppendApiKeyInUrlWithOneQueryItems() {
        //GIVEN
        var url = "www.mytests.com?param1=param1"
        let apiKey = "myApiKey"
        //WHEN
        url = url.appendApiKey(apiKey)
        //THEN
        XCTAssertEqual(url, "www.mytests.com?param1=param1&api_key=\(apiKey)")
    }

    func testAppendApiKeyInUrlWithMoreThanOneQueryItems() {
        //GIVEN
        var url = "www.mytests.com?param1=param1&param2=param2"
        let apiKey = "myApiKey"
        //WHEN
        url = url.appendApiKey(apiKey)
        //THEN
        XCTAssertEqual(url, "www.mytests.com?param1=param1&param2=param2&api_key=\(apiKey)")
    }
}
