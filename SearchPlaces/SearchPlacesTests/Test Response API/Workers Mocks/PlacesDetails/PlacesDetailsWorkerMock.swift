//
//  PlacesDetailsWorkerMock.swift
//  SearchPlacesTests
//
//  Created by Ruben Duarte on 31/1/22.
//

import Foundation
@testable import SearchPlaces

class PlacesDetailsWorkerMock : PlacesDetailsServiceProtocol {
    
    var resultGetPlacesDetails: (Result<[PlacesDetailsModel.GetDetailsPlaces.Response], MainError>)?
    
    var isFunctionWasCalled = false
    
    func getPlacesDetails(request: PlacesDetailsModel.GetDetailsPlaces.Request, completion: @escaping (Result<[PlacesDetailsModel.GetDetailsPlaces.Response], MainError>) -> Void) {
        if let result = resultGetPlacesDetails {
            isFunctionWasCalled = true
            completion(result)
        }
    }
    
}
