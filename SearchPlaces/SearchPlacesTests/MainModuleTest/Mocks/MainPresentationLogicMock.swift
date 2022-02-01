//
//  MainPresentationLogicMock.swift
//  SearchPlacesTests
//
//  Created by Ruben Duarte on 31/1/22.
//

import Foundation
@testable import SearchPlaces

final class MainPresentationLogicMock: MainPresentationLogic {
    
    var responseNearbyPlaces: MainModel.GetNearbyPlaces.Response?
    var isFunctionWasCalled = false
    
    func presentNearbyPlaces(response: MainModel.GetNearbyPlaces.Response) {
        if responseNearbyPlaces != nil {
            isFunctionWasCalled = true
        }
    }
    
    func presentError(response: MainModel.Error.Response) {
        isFunctionWasCalled = true
    }
}
