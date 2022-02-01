//
//  MainInteractor.swift
//  SearchPlaces
//
//  Created by Carlos Villamizar on 27/1/22.
//

import UIKit

protocol MainBusinessLogic {
    func getNearbyPlaces(request: MainModel.GetNearbyPlaces.Request)
}

protocol MainDataStore {
}

class MainInteractor: MainBusinessLogic, MainDataStore {
    
    var presenter: MainPresentationLogic?
    var worker: MainServiceProtocol
    
    init(worker: MainServiceProtocol = MainAPI()) {
        self.worker = worker
    }
  
    // MARK: - Methods
    func getNearbyPlaces(request: MainModel.GetNearbyPlaces.Request) {
        worker.getNearbyPlaces(request: request) { result in
            switch result {
            case .success(let response):
                self.presenter?.presentNearbyPlaces(response: response)
            case .failure(let error):
                let response = MainModel.Error.Response(error: error)
                self.presenter?.presentError(response: response)
            }
        }
    }
}
