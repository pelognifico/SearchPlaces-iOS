//
//  MainPresent.swift
//  SearchPlaces
//
//  Created by Carlos Villamizar on 27/1/22.
//

import Foundation

protocol MainPresentationLogic {
    func presentNearbyPlaces(response: MainModel.GetNearbyPlaces.Response)
    func presentError(response: MainModel.Error.Response)
}

class MainPresenter: MainPresentationLogic {
    
    weak var viewController: MainDisplayLogic?
  
    // MARK: - Present Places
    func presentNearbyPlaces(response: MainModel.GetNearbyPlaces.Response) {
        let viewModel = MainModel.GetNearbyPlaces.ViewModel(placesList: response.results)
        viewController?.displayNearbyPlaces(viewModel: viewModel, on: .main)
    }
    
    // MARK: - Present Error
    func presentError(response: MainModel.Error.Response) {
        let viewModel = MainModel.Error.ViewModel(error: response.error)
        viewController?.displayError(viewModel: viewModel, on: .main)
    }
}
