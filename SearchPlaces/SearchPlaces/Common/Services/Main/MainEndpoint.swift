//
//  MainEndpoint.swift
//  SearchPlaces
//
//  Created by Carlos Villamizar on 27/1/22.
//

import Alamofire

enum MainEndpoint {
    case getNearbyPlaces(ll: String)
    case getAutocomplete(query: String, ll: String)
}

extension MainEndpoint: IEndpoint {
    var method: HTTPMethod {
        switch self {
        case .getNearbyPlaces, .getAutocomplete:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getNearbyPlaces(let ll):
            return "places/nearby?ll=\(ll)"
        case .getAutocomplete(let query, let ll):
            return "autocomplete?query=\(query)&ll=\(ll)"
        }
    }
    
    var parameter: Parameters? {
        switch self {
        case .getNearbyPlaces, .getAutocomplete:
            return nil
        }
    }
    
    var header: HTTPHeaders? {
        switch self {
        case .getNearbyPlaces, .getAutocomplete:
            return ["Accept": "application/json",
                    "Authorization": "fsq3cOOva3JVjhC10VsIZ3CxscWpJ6Qwvn2yHkKVtQQjbnM="]
        }
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
