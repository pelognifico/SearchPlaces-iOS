//
//  PlacesDetailsPresenter.swift
//  SearchPlaces
//
//  Created by Carlos Villamizar on 28/1/22.
//

import Foundation

protocol PlacesDetailsPresentationLogic {
    func presentDetailsPlaces(response: [PlacesDetailsModel.GetDetailsPlaces.Response])
    func presentError(response: PlacesDetailsModel.Error.Response)
}

class PlacesDetailsPresenter: PlacesDetailsPresentationLogic {
    
    weak var viewController: PlacesDetailsDisplayLogic?
  
    // MARK: - Present Places
    func presentDetailsPlaces(response: [PlacesDetailsModel.GetDetailsPlaces.Response]) {
        let viewModel = PlacesDetailsModel.GetDetailsPlaces.ViewModel(data: response)
        viewController?.displayDetailsPlaces(viewModel: viewModel, on: .main)
    }
    
    // MARK: - Present Error
    func presentError(response: PlacesDetailsModel.Error.Response) {
        let viewModel = PlacesDetailsModel.Error.ViewModel(error: response.error)
        viewController?.displayError(viewModel: viewModel, on: .main)
    }
}
