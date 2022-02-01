//
//  MainViewControllerTest.swift
//  SearchPlacesTests
//
//  Created by Carlos Villamizar on 31/1/22.
//

import XCTest
import Foundation
@testable import SearchPlaces

class MainViewControllerTest: XCTestCase {
    var sut: MainViewController!
    var viewControllerMock: MainDisplayLogicMock!
    
    override func setUp() {
        super.setUp()
        
        viewControllerMock = MainDisplayLogicMock()
        sut = MainViewController()
    }
    
    func testGetMovies() {
        //Given
        let nearbyPlacesResponseMock : [NearbyPlaces] = [.init(fsq_id: "ABC", categories: .none, chains: .none, distance: 123, geocodes: .none, location: .none, name: "ABC", related_places: .none, timezone: "ABC")]
        let responseMock = nearbyPlacesResponseMock
        
        let viewModel = MainModel.GetNearbyPlaces.ViewModel(placesList: responseMock)
        let queue = DispatchQueue(label: "FileLoaderTests")
        
        viewControllerMock.displayNearbyPlaces(viewModel: viewModel, on: queue)
        
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
//        let responseMock = Main.Error.Response(error: error)
        let viewModel = MainModel.Error.ViewModel(error: error)
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
