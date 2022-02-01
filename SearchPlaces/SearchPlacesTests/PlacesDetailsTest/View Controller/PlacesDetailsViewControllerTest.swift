//
//  PostsHomeViewControllerTest.swift
//  SearchPlacesTests
//
//  Created by Carlos Villamizar on 31/1/22.
//

import XCTest
import Foundation
@testable import SearchPlaces

class PlacesDetailsViewControllerTest: XCTestCase {
    var sut: PlacesDetailsViewController!
    var viewControllerMock: PlacesDetailsDisplayLogicMock!
    
    override func setUp() {
        super.setUp()
        
        viewControllerMock = PlacesDetailsDisplayLogicMock()
        sut = PlacesDetailsViewController()
    }
    
    func testGetDetailsPlaces() {
        //Given
        let responseMock = [PlacesDetailsModel.GetDetailsPlaces.Response(id: "ABC", created_at: "BCB", prefix: "ABC", suffix: "ABC", width: 123, height: 132, classifications: .none)]
        
        let viewModel = PlacesDetailsModel.GetDetailsPlaces.ViewModel(data: responseMock)
        let queue = DispatchQueue(label: "FileLoaderTests")
        
        viewControllerMock.displayDetailsPlaces(viewModel: viewModel, on: queue)
        
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
        let viewModel = PlacesDetailsModel.Error.ViewModel(error: error)
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
