//
//  SearchPlacesRouter.swift
//  SearchPlaces
//
//  Created by Ruben Duarte on 31/1/22.
//

import Foundation

@objc protocol SearchPlacesRoutingLogic {
}

protocol SearchPlacesDataPassing {
    var dataStore: SearchPlacesDataStore? { get }
}

class SearchPlacesRouter: NSObject, SearchPlacesRoutingLogic, SearchPlacesDataPassing {
    weak var viewController: SearchPlacesViewController?
    var dataStore: SearchPlacesDataStore?
  
}
