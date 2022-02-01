//
//  MainEndpointTest.swift
//  SearchPlacesTests
//
//  Created by Carlos Villamizar on 1/2/22.
//

import XCTest
@testable import SearchPlaces

class PlacesDetailsEndpointTest: XCTestCase {
    var sut: PlacesDetailsEndpoint!
    
    //MARK: - GET METHOD
    
    func testGetPlacesDetails() {
        sut = .getPlacesDetails(fsq_id: "67676798hjhj")

        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.path, "places/67676798hjhj/photos")
        XCTAssertNil(sut.parameter)
    }
}
