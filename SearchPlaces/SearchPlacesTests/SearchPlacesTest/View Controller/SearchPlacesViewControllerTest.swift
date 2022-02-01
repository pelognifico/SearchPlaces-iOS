//
//  SearchPlacesViewControllerTest.swift
//  SearchPlacesTests
//
//  Created by Carlos Villamizar on 31/1/22.
//

import XCTest
import Foundation
@testable import SearchPlaces

class SearchPlacesViewControllerTest: XCTestCase {
    var sut: SearchPlacesViewController!
    var viewControllerMock: SearchPlacesDisplayLogicMock!
    
    override func setUp() {
        super.setUp()
        
        viewControllerMock = SearchPlacesDisplayLogicMock()
        sut = SearchPlacesViewController()
    }
    
    func testGetAutocomplete() {
        //Given
        let searchPlacesResponseMock : [SearchPlaces] = [.init(type: "ABC", text: .none, link: "ABC", place: .none, name: "ABC")]
        let responseMock = searchPlacesResponseMock
        
        let viewModel = SearchPlacesModel.GetAutocomplete.ViewModel(placesList: responseMock)
        let queue = DispatchQueue(label: "FileLoaderTests")
        
        viewControllerMock.displayAutocomplete(viewModel: viewModel, on: queue)
        
        //When
        queue.sync {
            sut.loadInitialData()
        }
        
        let result = viewControllerMock.isFunctionWasCalled
        
        //Then
        XCTAssertTrue((result))
    }
    
    func testFailure() {
        //Given
        let error: MainError = .request
        let viewModel = SearchPlacesModel.Error.ViewModel(error: error)
        let queue = DispatchQueue(label: "FileLoaderTests")
        viewControllerMock.displayError(viewModel: viewModel, on: queue)
        
        //When
        queue.sync {
            sut.displayError(viewModel: viewModel, on: queue)
        }
        
        let result = viewControllerMock.isFunctionWasCalled
        
        //Then
        XCTAssertTrue((result))
    }
    
}
