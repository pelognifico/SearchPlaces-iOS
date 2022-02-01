//
//  MainFailureResponse.swift
//  SearchPlacesTests
//
//  Created by Carlos Villamizar on 31/1/22.
//

import XCTest
@testable import SearchPlaces

class MainFailureResponse: XCTestCase {
    var sut: MainAPI!
    var mainServiceProtocolMock: MainWorkerMock!
    
    override func setUp() {
        mainServiceProtocolMock = MainWorkerMock()
        sut = MainAPI()
    }
    
    //MARK: -- Test NearbyPlaces
    func testGetNearbyPlaces(){
        //Given
        let requestData = MainModel.GetNearbyPlaces.Request(ll: "ABC")
        let failure : MainError = .request
        
        //When
        mainServiceProtocolMock.resultGetNearbyPlaces = .failure(failure)
        
        //Then
        sut.getNearbyPlaces(request: requestData, completion: { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(error.localizedDescription, failure.localizedDescription)
            }
        })
    }
    
    //MARK: -- Test Autocomplete
    func testGetAutocomplete(){
        //Given
        let requestData = SearchPlacesModel.GetAutocomplete.Request(query: "ABC", ll: "232")
        let failure : MainError = .request
        
        //When
        mainServiceProtocolMock.resultGetAutocomplete = .failure(failure)
        
        //Then
        sut.getAutocomplete(request: requestData, completion: { result in
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
