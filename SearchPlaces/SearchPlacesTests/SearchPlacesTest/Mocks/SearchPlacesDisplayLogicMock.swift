//
//  SearchPlacesDisplayLogicMock.swift
//  SearchPlacesTests
//
//  Created by Carlos Villamizar on 31/1/22.
//

import Foundation
@testable import SearchPlaces

final class SearchPlacesDisplayLogicMock: SearchPlacesDisplayLogic {
    
    var viewModelDisplayNearbyPlaces: SearchPlacesModel.GetAutocomplete.ViewModel?
    var isFunctionWasCalled = false
    
    func displayAutocomplete(viewModel: SearchPlacesModel.GetAutocomplete.ViewModel, on queu: DispatchQueue) {
        isFunctionWasCalled = true
    }
    
    func displayError(viewModel: SearchPlacesModel.Error.ViewModel, on queu: DispatchQueue) {
        isFunctionWasCalled = true
    }
}
