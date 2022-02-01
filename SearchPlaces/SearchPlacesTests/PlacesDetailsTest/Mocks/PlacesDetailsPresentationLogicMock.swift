//
//  PlacesDetailsPresentationLogicMock.swift
//  SearchPlacesTests
//
//  Created by Carlos Villamizar on 31/1/22.
//

import Foundation
@testable import SearchPlaces

final class PlacesDetailsPresentationLogicMock: PlacesDetailsPresentationLogic {
    
    var responseDetailsPlaces: PlacesDetailsModel.GetDetailsPlaces.Response?
    var isFunctionWasCalled = false
    
    func presentDetailsPlaces(response: [PlacesDetailsModel.GetDetailsPlaces.Response]) {
        if responseDetailsPlaces != nil {
            isFunctionWasCalled = true
        }
    }
    
    func presentError(response: PlacesDetailsModel.Error.Response) {
        isFunctionWasCalled = true
    }
}
