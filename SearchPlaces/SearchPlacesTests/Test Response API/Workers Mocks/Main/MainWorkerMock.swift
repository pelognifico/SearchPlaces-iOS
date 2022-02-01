//
//  MainWorkerMock.swift
//  SearchPlacesTests
//
//  Created by Carlos Villamizar on 31/1/22.
//

import Foundation
@testable import SearchPlaces

class MainWorkerMock : MainServiceProtocol {
    
    var resultGetNearbyPlaces: (Result<MainModel.GetNearbyPlaces.Response, MainError>)?
    var resultGetAutocomplete: (Result<SearchPlacesModel.GetAutocomplete.Response, MainError>)?
    
    var isFunctionWasCalled = false
    
    func getNearbyPlaces(request: MainModel.GetNearbyPlaces.Request, completion: @escaping (Result<MainModel.GetNearbyPlaces.Response, MainError>) -> Void) {
        if let result = resultGetNearbyPlaces {
            isFunctionWasCalled = true
            completion(result)
        }
    }
    
    func getAutocomplete(request: SearchPlacesModel.GetAutocomplete.Request, completion: @escaping (Result<SearchPlacesModel.GetAutocomplete.Response, MainError>) -> Void) {
        if let result = resultGetAutocomplete {
            isFunctionWasCalled = true
            completion(result)
        }
    }
}
