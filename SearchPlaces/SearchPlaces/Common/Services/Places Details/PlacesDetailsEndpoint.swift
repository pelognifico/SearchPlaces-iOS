//
//  PlacesDetailsEndpoint.swift
//  SearchPlaces
//
//  Created by Carlos Villamizar on 28/1/22.
//

import Alamofire

enum PlacesDetailsEndpoint {
    case getPlacesDetails(fsq_id: String)
}

extension PlacesDetailsEndpoint: IEndpoint {
    var method: HTTPMethod {
        switch self {
        case .getPlacesDetails:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getPlacesDetails(let fsq_id):
            return "places/\(fsq_id)/photos"
        }
    }
    
    var parameter: Parameters? {
        switch self {
        case .getPlacesDetails:
            return nil
        }
    }
    
    var header: HTTPHeaders? {
        switch self {
        case .getPlacesDetails:
            return ["Accept": "application/json",
                    "Authorization": "fsq3cOOva3JVjhC10VsIZ3CxscWpJ6Qwvn2yHkKVtQQjbnM="]
        }
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
