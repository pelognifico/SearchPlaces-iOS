//
//  GeneralRoute.swift
//  SearchPlaces
//
//  Created by Carlos Villamizar on 27/1/22.
//

import Foundation
import UIKit

enum GeneralRoute: IRouter {
    case main
}

extension GeneralRoute {
    var scene: UIViewController? {
        switch self {
        case .main:
            return MainViewController()
        }
    }
}
