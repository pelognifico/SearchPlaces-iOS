//
//  PlacesDetailsDisplayLogicMock.swift
//  SearchPlacesTests
//
//  Created by Carlos Villamizar on 31/1/22.
//

import Foundation
@testable import SearchPlaces

final class PlacesDetailsDisplayLogicMock: PlacesDetailsDisplayLogic {
    
    var viewModelDisplayDetailsPlaces: PlacesDetailsModel.GetDetailsPlaces.ViewModel?
    var isFunctionWasCalled = false
    
    func displayDetailsPlaces(viewModel: PlacesDetailsModel.GetDetailsPlaces.ViewModel, on queu: DispatchQueue) {
        isFunctionWasCalled = true
    }
    
    func displayError(viewModel: PlacesDetailsModel.Error.ViewModel, on queu: DispatchQueue) {
        isFunctionWasCalled = true
    }
}
