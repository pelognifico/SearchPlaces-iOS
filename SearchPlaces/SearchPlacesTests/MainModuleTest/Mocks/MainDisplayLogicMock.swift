//
//  MainDisplayLogicMock.swift
//  SearchPlacesTests
//
//  Created by Ruben Duarte on 31/1/22.
//

import Foundation
@testable import SearchPlaces

final class MainDisplayLogicMock: MainDisplayLogic {
    
    var viewModelDisplayNearbyPlaces: MainModel.GetNearbyPlaces.ViewModel?
    var isFunctionWasCalled = false
    
    func displayNearbyPlaces(viewModel: MainModel.GetNearbyPlaces.ViewModel, on queu: DispatchQueue) {
        isFunctionWasCalled = true
    }
    
    func displayError(viewModel: MainModel.Error.ViewModel, on queu: DispatchQueue) {
        isFunctionWasCalled = true
    }
}
