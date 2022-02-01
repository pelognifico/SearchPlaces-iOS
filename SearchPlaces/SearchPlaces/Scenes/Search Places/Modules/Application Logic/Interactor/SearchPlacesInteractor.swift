//
//  SearchPlacesInteractor.swift
//  SearchPlaces
//
//  Created by Ruben Duarte on 31/1/22.
//

import UIKit

protocol SearchPlacesBusinessLogic {
    func getAutocomplete(request: SearchPlacesModel.GetAutocomplete.Request)
}

protocol SearchPlacesDataStore {
}

class SearchPlacesInteractor: SearchPlacesBusinessLogic, SearchPlacesDataStore {
    
    var presenter: SearchPlacesPresentationLogic?
    var worker: MainServiceProtocol
    
    init(worker: MainServiceProtocol = MainAPI()) {
        self.worker = worker
    }
  
    // MARK: - Methods
    func getAutocomplete(request: SearchPlacesModel.GetAutocomplete.Request) {
        worker.getAutocomplete(request: request) { result in
            switch result {
            case .success(let response):
                self.presenter?.presentAutocomplete(response: response)
            case .failure(let error):
                let response = SearchPlacesModel.Error.Response(error: error)
                self.presenter?.presentError(response: response)
            }
        }
    }
}
