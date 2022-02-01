//
//  PlacesDetailsSuccessResponse.swift
//  SearchPlacesTests
//
//  Created by Carlos Villamizar on 31/1/22.
//

import XCTest
@testable import SearchPlaces

class PlacesDetailsSuccessResponse: XCTestCase {
    var sut: PlacesDetailsAPI!
    var placesDetailsServiceProtocolMock: PlacesDetailsWorkerMock!
    
    override func setUp() {
        placesDetailsServiceProtocolMock = PlacesDetailsWorkerMock()
        sut = PlacesDetailsAPI()
    }
    
    //MARK: -- Test Posts
    func testGetPlacesDetails(){
        //Given
        let requestData = PlacesDetailsModel.GetDetailsPlaces.Request(fsq_id: "ABC")
        let dataMock = PlacesDetailsModel.GetDetailsPlaces.Response(id: "ABC", created_at: "ABC", prefix: "ABC", suffix: "ABC", width: 123, height: 123, classifications: .none)
        let success : [PlacesDetailsModel.GetDetailsPlaces.Response]? = .some([dataMock])
        
        //When
        placesDetailsServiceProtocolMock.resultGetPlacesDetails = .success(success!)
        
        //Then
        sut.getPlacesDetails(request: requestData, completion: { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
                XCTAssertEqual(response[0].id, dataMock.id)
                XCTAssertEqual(response[0].created_at, dataMock.created_at)
                XCTAssertEqual(response[0].prefix, dataMock.prefix)
                XCTAssertEqual(response[0].suffix, dataMock.suffix)
                XCTAssertEqual(response[0].width, dataMock.width)
                XCTAssertEqual(response[0].height, dataMock.height)
                XCTAssertEqual(response[0].classifications, dataMock.classifications)
            case .failure(_):
                break
            }
        })
    }
    
}

