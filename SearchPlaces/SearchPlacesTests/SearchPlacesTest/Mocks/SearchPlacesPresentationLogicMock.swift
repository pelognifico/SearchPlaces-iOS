//
//  SearchPlacesPresentationLogicMock.swift
//  SearchPlacesTests
//
//  Created by Carlos Villamizar on 31/1/22.
//

import Foundation
@testable import SearchPlaces

final class SearchPlacesPresentationLogicMock: SearchPlacesPresentationLogic {
    
    var responseSearchPlaces: SearchPlacesModel.GetAutocomplete.Response?
    var isFunctionWasCalled = false
    
    func presentAutocomplete(response: SearchPlacesModel.GetAutocomplete.Response) {
        if responseSearchPlaces != nil {
            isFunctionWasCalled = true
        }
    }
    
    func presentError(response: SearchPlacesModel.Error.Response) {
        isFunctionWasCalled = true
    }
}
