//
//  SearchPlacesInteractorTest.swift
//  SearchPlacesTests
//
//  Created by Carlos Villamizar on 31/1/22.
//

import XCTest
import Foundation
@testable import SearchPlaces

class SearchPlacesInteractorTest: XCTestCase {
    var sut: SearchPlacesInteractor!
    var searchPlacesPresenterMock: MainWorkerMock!
    
    override func setUp() {
        searchPlacesPresenterMock = MainWorkerMock()
        sut = SearchPlacesInteractor(worker: searchPlacesPresenterMock)
    }
    
    func testSearchPlacesSuccess() {
        //Given
        let requestData = SearchPlacesModel.GetAutocomplete.Request(query: "ABC", ll: "ABC")
        let searchPlacesResponseMock : [SearchPlaces] = [.init(type: "ABC", text: .none, link: "ABC", place: .none, name: "ABC")]
        let responseMock = SearchPlacesModel.GetAutocomplete.Response(results: searchPlacesResponseMock)
        
        searchPlacesPresenterMock.resultGetAutocomplete = .success(responseMock)
        searchPlacesPresenterMock.isFunctionWasCalled = false
        
        //When
        sut.getAutocomplete(request: requestData)
        let result = searchPlacesPresenterMock.isFunctionWasCalled
        
        //Then
        XCTAssertTrue(result)
    }
    
    func testSearchPlacesFailure() {
        //Given
        let requestData = SearchPlacesModel.GetAutocomplete.Request(query: "ABC", ll: "ABC")
        let failure : MainError = .request

        searchPlacesPresenterMock.resultGetAutocomplete = .failure(failure)
        searchPlacesPresenterMock.isFunctionWasCalled = false

        //When
        sut.getAutocomplete(request: requestData)
        let result = searchPlacesPresenterMock.isFunctionWasCalled

        //Then
        XCTAssertTrue(result)
    }
}
