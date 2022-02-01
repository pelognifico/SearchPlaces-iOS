//
//  PlacesDetailsInteractor.swift
//  SearchPlaces
//
//  Created by Carlos Villamizar on 28/1/22.
//

import UIKit

protocol PlacesDetailsBusinessLogic {
    func getDetailsPlaces(request: PlacesDetailsModel.GetDetailsPlaces.Request)
}

protocol PlacesDetailsDataStore {
}

class PlacesDetailsInteractor: PlacesDetailsBusinessLogic, PlacesDetailsDataStore {
    
    var presenter: PlacesDetailsPresentationLogic?
    var worker: PlacesDetailsServiceProtocol
    
    init(worker: PlacesDetailsServiceProtocol = PlacesDetailsAPI()) {
        self.worker = worker
    }
  
    // MARK: - Methods
    func getDetailsPlaces(request: PlacesDetailsModel.GetDetailsPlaces.Request) {
        worker.getPlacesDetails(request: request) { result in
            switch result {
            case .success(let response):
                self.presenter?.presentDetailsPlaces(response: response)
            case .failure(let error):
                let response = PlacesDetailsModel.Error.Response(error: error)
                self.presenter?.presentError(response: response)
            }
        }
    }
}
