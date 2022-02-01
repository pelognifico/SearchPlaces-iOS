//
//  MainSuccessResponse.swift
//  SearchPlacesTests
//
//  Created by Ruben Duarte on 31/1/22.
//

import XCTest
@testable import SearchPlaces

class MainSuccessResponse: XCTestCase {
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
        let nearbyPlacesResponseMock : [NearbyPlaces] = [.init(fsq_id: "ABC", categories: .none, chains: .none, distance: 123, geocodes: .none, location: .none, name: "ABC", related_places: .none, timezone: "ABC")]
        let dataMock = MainModel.GetNearbyPlaces.Response(results: nearbyPlacesResponseMock)
        let success : MainModel.GetNearbyPlaces.Response? = .some(dataMock)
        
        //When
        mainServiceProtocolMock.resultGetNearbyPlaces = .success(success!)
        
        //Then
        sut.getNearbyPlaces(request: requestData, completion: { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
                XCTAssertNotNil(response.results)
                XCTAssertEqual(response.results?.count, dataMock.results?.count)
            case .failure(_):
                break
            }
        })
    }
    
    //MARK: -- Test Autocomplete
    func testGetAutocomplete(){
        //Given
        let requestData = SearchPlacesModel.GetAutocomplete.Request(query: "ABC", ll: "232")
        let autocompleteResponseMock : [SearchPlaces] = [.init(type: "ABC", text: .none, link: "ABC", place: .none, name: "ABC")]
        let dataMock = SearchPlacesModel.GetAutocomplete.Response(results: autocompleteResponseMock)
        let success : SearchPlacesModel.GetAutocomplete.Response? = .some(dataMock)

        //When
        mainServiceProtocolMock.resultGetAutocomplete = .success(success!)

        //Then
        sut.getAutocomplete(request: requestData, completion: { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
                XCTAssertNotNil(response.results)
                XCTAssertEqual(response.results?.count, dataMock.results?.count)
            case .failure(_):
                break
            }
        })
    }
}
