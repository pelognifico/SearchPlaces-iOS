//
//  SearchPlacesPresenter.swift
//  SearchPlaces
//
//  Created by Carlos Villamizar on 31/1/22.
//

import Foundation

protocol SearchPlacesPresentationLogic {
    func presentAutocomplete(response: SearchPlacesModel.GetAutocomplete.Response)
    func presentError(response: SearchPlacesModel.Error.Response)
}

class SearchPlacesPresenter: SearchPlacesPresentationLogic {
    
    weak var viewController: SearchPlacesDisplayLogic?
  
    // MARK: - Present Places
    func presentAutocomplete(response: SearchPlacesModel.GetAutocomplete.Response) {
        let viewModel = SearchPlacesModel.GetAutocomplete.ViewModel(placesList: response.results)
        viewController?.displayAutocomplete(viewModel: viewModel, on: .main)
    }
    
    // MARK: - Present Error
    func presentError(response: SearchPlacesModel.Error.Response) {
        let viewModel = SearchPlacesModel.Error.ViewModel(error: response.error)
        viewController?.displayError(viewModel: viewModel, on: .main)
    }
}
