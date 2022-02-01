//
//  MainInteractorTest.swift
//  SearchPlacesTests
//
//  Created by Ruben Duarte on 31/1/22.
//

import XCTest
import Foundation
@testable import SearchPlaces

class MainInteractorTest: XCTestCase {
    var sut: MainInteractor!
    var mainPresenterMock: MainWorkerMock!
    
    override func setUp() {
        mainPresenterMock = MainWorkerMock()
        sut = MainInteractor(worker: mainPresenterMock)
    }
    
    func testNearbyPlacesSuccess() {
        //Given
        let requestData = MainModel.GetNearbyPlaces.Request(ll: "ABC")
        let nearbyPlacesResponseMock : [NearbyPlaces] = [.init(fsq_id: "ABC", categories: .none, chains: .none, distance: 123, geocodes: .none, location: .none, name: "ABC", related_places: .none, timezone: "ABC")]
        let responseMock = MainModel.GetNearbyPlaces.Response(results: nearbyPlacesResponseMock)
        
        mainPresenterMock.resultGetNearbyPlaces = .success(responseMock)
        mainPresenterMock.isFunctionWasCalled = false
        
        //When
        sut.getNearbyPlaces(request: requestData)
        let result = mainPresenterMock.isFunctionWasCalled
        
        //Then
        XCTAssertTrue(result)
    }
    
    func testNearbyPlacesFailure() {
        //Given
        let requestData = MainModel.GetNearbyPlaces.Request(ll: "ABC")
        let failure : MainError = .request

        mainPresenterMock.resultGetNearbyPlaces = .failure(failure)
        mainPresenterMock.isFunctionWasCalled = false

        //When
        sut.getNearbyPlaces(request: requestData)
        let result = mainPresenterMock.isFunctionWasCalled

        //Then
        XCTAssertTrue(result)
    }
}
