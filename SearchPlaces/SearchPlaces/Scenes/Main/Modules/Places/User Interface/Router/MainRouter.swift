//
//  MainRouter.swift
//  SearchPlaces
//
//  Created by Carlos Villamizar on 27/1/22.
//

import Foundation

@objc protocol MainRoutingLogic {
}

protocol MainDataPassing {
    var dataStore: MainDataStore? { get }
}

class MainRouter: NSObject, MainRoutingLogic, MainDataPassing {
    weak var viewController: MainViewController?
    var dataStore: MainDataStore?
  
}
