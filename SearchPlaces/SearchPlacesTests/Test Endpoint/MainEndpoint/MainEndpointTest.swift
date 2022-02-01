//
//  MainEndpointTest.swift
//  SearchPlacesTests
//
//  Created by Carlos Villamizar on 31/1/22.
//

import XCTest
@testable import SearchPlaces

class MainEndpointTest: XCTestCase {
    var sut: MainEndpoint!
    
    //MARK: - GET METHOD
    
    func testGetNearbyPlaces() {
        sut = .getNearbyPlaces(ll: "47.608013,-122.335167")

        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.path, "places/nearby?ll=47.608013,-122.335167")
        XCTAssertNil(sut.parameter)
    }
    
    func testGetAutocomplete() {
        sut = .getAutocomplete(query: "coffee", ll: "47.608013,-122.335167")

        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.path, "autocomplete?query=coffee&ll=47.608013,-122.335167")
        XCTAssertNil(sut.parameter)
    }
}

