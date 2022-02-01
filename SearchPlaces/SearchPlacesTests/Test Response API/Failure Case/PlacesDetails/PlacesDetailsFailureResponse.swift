//
//  PlacesDetailsFailureResponse.swift
//  SearchPlacesTests
//
//  Created by Ruben Duarte on 31/1/22.
//

import XCTest
@testable import SearchPlaces

class PlacesDetailsFailureResponse: XCTestCase {
    var sut: PlacesDetailsAPI!
    var placesDetailsServiceProtocolMock: PlacesDetailsWorkerMock!
    
    override func setUp() {
        placesDetailsServiceProtocolMock = PlacesDetailsWorkerMock()
        sut = PlacesDetailsAPI()
    }
    
    //MARK: -- Test NearbyPlaces
    func testGetPlacesDetails(){
        //Given
        let requestData = PlacesDetailsModel.GetDetailsPlaces.Request(fsq_id: "ABC")
        let failure : MainError = .request
        
        //When
        placesDetailsServiceProtocolMock.resultGetPlacesDetails = .failure(failure)
        
        //Then
        sut.getPlacesDetails(request: requestData, completion: { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(error.localizedDescription, failure.localizedDescription)
            }
        })
    }
    
}
