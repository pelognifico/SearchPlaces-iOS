//
//  PlacesDetailsPresenterTest.swift
//  SearchPlacesTests
//
//  Created by Carlos Villamizar on 31/1/22.
//

import XCTest
import Foundation
@testable import SearchPlaces

class PlacesDetailsPresenterTest: XCTestCase {
    var sut: PlacesDetailsPresenter!
    var viewControllerMock: PlacesDetailsDisplayLogicMock!
    
    override func setUp() {
        viewControllerMock = PlacesDetailsDisplayLogicMock()
        sut = PlacesDetailsPresenter()
        sut.viewController = viewControllerMock
    }
    
    func testPresentPlacesDetailsSuccess() {
        //Given
        let responseMock = [PlacesDetailsModel.GetDetailsPlaces.Response(id: "ABC", created_at: "BCB", prefix: "ABC", suffix: "ABC", width: 123, height: 132, classifications: .none)]
        
        let viewModel = PlacesDetailsModel.GetDetailsPlaces.ViewModel(data: [])
        let queue = DispatchQueue(label: "FileLoaderTests")
        viewControllerMock.displayDetailsPlaces(viewModel: viewModel, on: queue)
        
        //When
        queue.sync {
            sut.presentDetailsPlaces(response: responseMock)
        }
        
        let result = viewControllerMock.isFunctionWasCalled
        
        //Then
        XCTAssertTrue((result))
    }
    
    func testPresentDetailsPlacesFailure() {
        //Given
        let error: MainError = .request
        let responseMock = PlacesDetailsModel.Error.Response(error: error)
        let viewModel = PlacesDetailsModel.Error.ViewModel(error: error)
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
