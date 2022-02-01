//
//  PlacesDetailsInteractorTest.swift
//  SearchPlacesTests
//
//  Created by Carlos Villamizar on 31/1/22.
//

import XCTest
import Foundation
@testable import SearchPlaces

class PlacesDetailsInteractorTest: XCTestCase {
    var sut: PlacesDetailsInteractor!
    var placesDetailsPresenterMock: PlacesDetailsWorkerMock!
    
    override func setUp() {
        placesDetailsPresenterMock = PlacesDetailsWorkerMock()
        sut = PlacesDetailsInteractor(worker: placesDetailsPresenterMock)
    }
    
    func testPlacesDetails() {
        //Given
        let requestData = PlacesDetailsModel.GetDetailsPlaces.Request(fsq_id: "ABC")
        let responseMock = [PlacesDetailsModel.GetDetailsPlaces.Response(id: "ABC", created_at: "ABC", prefix: "ABC", suffix: "ABC", width: 123, height: 123, classifications: .none)]
        
        placesDetailsPresenterMock.resultGetPlacesDetails = .success(responseMock)
        placesDetailsPresenterMock.isFunctionWasCalled = false
        
        //When
        sut.getDetailsPlaces(request: requestData)
        let result = placesDetailsPresenterMock.isFunctionWasCalled
        
        //Then
        XCTAssertTrue(result)
    }
    
    func testNearbyPlacesFailure() {
        //Given
        let requestData = PlacesDetailsModel.GetDetailsPlaces.Request(fsq_id: "ABC")
        let failure : MainError = .request

        placesDetailsPresenterMock.resultGetPlacesDetails = .failure(failure)
        placesDetailsPresenterMock.isFunctionWasCalled = false

        //When
        sut.getDetailsPlaces(request: requestData)
        let result = placesDetailsPresenterMock.isFunctionWasCalled

        //Then
        XCTAssertTrue(result)
    }
}
