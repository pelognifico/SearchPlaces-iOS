//
//  PlacesDetailsRouter.swift
//  SearchPlaces
//
//  Created by Carlos Villamizar on 28/1/22.
//

import Foundation

@objc protocol PlacesDetailsRoutingLogic {
}

protocol PlacesDetailsDataPassing {
    var dataStore: PlacesDetailsDataStore? { get }
}

class PlacesDetailsRouter: NSObject, PlacesDetailsRoutingLogic, PlacesDetailsDataPassing {
    weak var viewController: PlacesDetailsViewController?
    var dataStore: PlacesDetailsDataStore?
  
}
