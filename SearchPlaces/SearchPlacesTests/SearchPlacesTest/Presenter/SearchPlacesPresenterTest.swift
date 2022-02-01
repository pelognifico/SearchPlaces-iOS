//
//  SearchPlacesPresenterTest.swift
//  SearchPlacesTests
//
//  Created by Carlos Villamizar on 31/1/22.
//

import XCTest
import Foundation
@testable import SearchPlaces

class SearchPlacesPresenterTest: XCTestCase {
    var sut: SearchPlacesPresenter!
    var viewControllerMock: SearchPlacesDisplayLogicMock!
    
    override func setUp() {
        viewControllerMock = SearchPlacesDisplayLogicMock()
        sut = SearchPlacesPresenter()
        sut.viewController = viewControllerMock
    }
    
    func testPresentSearchPlacesSuccess() {
        //Given
        let searchPlacesResponseMock : [SearchPlaces] = [.init(type: "ABC", text: .none, link: "ABC", place: .none, name: "ABC")]
        let responseMock = SearchPlacesModel.GetAutocomplete.Response(results: searchPlacesResponseMock)
        
        let viewModel = SearchPlacesModel.GetAutocomplete.ViewModel(placesList: [])
        let queue = DispatchQueue(label: "FileLoaderTests")
        viewControllerMock.displayAutocomplete(viewModel: viewModel, on: queue)
        
        //When
        queue.sync {
            sut.presentAutocomplete(response: responseMock)
        }
        
        let result = viewControllerMock.isFunctionWasCalled
        
        //Then
        XCTAssertTrue((result))
    }
    
    func testPresentNearbyPlacesFailure() {
        //Given
        let error: MainError = .request
        let responseMock = SearchPlacesModel.Error.Response(error: error)
        let viewModel = SearchPlacesModel.Error.ViewModel(error: error)
        let queue = DispatchQueue(label: "FileLoaderTests")
        viewControllerMock.displayError(viewModel: viewModel, on: queue)
        
        //When
        queue.sync {
            sut.presentError(response: responseMock)
        }
        
        let result = viewControllerMock.isFunctionWasCalled
        
        //Then
        XCTAssertTrue((result))
    }
}
