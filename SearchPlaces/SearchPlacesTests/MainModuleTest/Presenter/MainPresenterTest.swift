//
//  MainPresenterTest.swift
//  SearchPlacesTests
//
//  Created by Ruben Duarte on 31/1/22.
//

import XCTest
import Foundation
@testable import SearchPlaces

class MainPresenterTest: XCTestCase {
    var sut: MainPresenter!
    var viewControllerMock: MainDisplayLogicMock!
    
    override func setUp() {
        viewControllerMock = MainDisplayLogicMock()
        sut = MainPresenter()
        sut.viewController = viewControllerMock
    }
    
    func testPresentNearbyPlacesSuccess() {
        //Given
        let nearbyPlacesResponseMock : [NearbyPlaces] = [.init(fsq_id: "ABC", categories: .none, chains: .none, distance: 123, geocodes: .none, location: .none, name: "ABC", related_places: .none, timezone: "ABC")]
        let responseMock = MainModel.GetNearbyPlaces.Response(results: nearbyPlacesResponseMock)
        
        let viewModel = MainModel.GetNearbyPlaces.ViewModel(placesList: [])
        let queue = DispatchQueue(label: "FileLoaderTests")
        viewControllerMock.displayNearbyPlaces(viewModel: viewModel, on: queue)
        
        //When
        queue.sync {
            sut.presentNearbyPlaces(response: responseMock)
        }
        
        let result = viewControllerMock.isFunctionWasCalled
        
        //Then
        XCTAssertTrue((result))
    }
    
    func testPresentNearbyPlacesFailure() {
        //Given
        let error: MainError = .request
        let responseMock = MainModel.Error.Response(error: error)
        let viewModel = MainModel.Error.ViewModel(error: error)
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
